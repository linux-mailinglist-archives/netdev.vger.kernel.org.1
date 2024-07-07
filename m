Return-Path: <netdev+bounces-109660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BDE929706
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 10:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF381281C7D
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 08:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0C4CA40;
	Sun,  7 Jul 2024 08:08:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5F1101CA;
	Sun,  7 Jul 2024 08:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720339710; cv=none; b=hT32yRP2OApYzPleNlJNUPfmaJrDEsuExVud5GZ/hpk0XR/hXyp6aTcTkBycvVYHrRLm8uok7otvlz7I+fg5I0BvaZhuzKhPeOpSxGNtM4xNgOCRS+cWCZrkshcar3sK/C1LIv1nhcG9DiMH/fGZ7N0dGqwgbrVOcwB25uB11JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720339710; c=relaxed/simple;
	bh=1rttPyuSa8fkhuT1EBmrD0ZvIWR2Zg1hG6GJRNc1R4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsP28g8eZJENpIsyIqqFDvL/EQeLKuFovqNav5reC2CHXM0eQg2XQEKqCjWW465jMU2RCFKQ7ycoU4iv9SOgzE6M1fXwPDU4wruHoFlXPsZ4sW6UreNwPSBZnoxoabOFrlpo0rOdq5ICPa+qCzc1Q6/A/qhg7Y2Zfca1JQF+wNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sQMwa-0007es-17; Sun, 07 Jul 2024 10:08:24 +0200
Date: Sun, 7 Jul 2024 10:08:24 +0200
From: Florian Westphal <fw@strlen.de>
To: Hillf Danton <hdanton@sina.com>
Cc: Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+4fd66a69358fc15ae2ad@syzkaller.appspotmail.com
Subject: Re: [PATCH nf] netfilter: nf_tables: unconditionally flush pending
 work before notifier
Message-ID: <20240707080824.GA29318@breakpoint.cc>
References: <20240705110218.GA1616@breakpoint.cc>
 <20240707075644.752-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240707075644.752-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hillf Danton <hdanton@sina.com> wrote:
> > I think this change might be useful as it also documents
> > this requirement.
> 
> Yes it is boy and the current reproducer triggered another warning [1,2].
> 
> [1] https://lore.kernel.org/lkml/20240706231332.3261-1-hdanton@sina.com/

The WARN is incorrect.  The destroy list can be non-empty; i already
tried to explain why.

