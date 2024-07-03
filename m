Return-Path: <netdev+bounces-108817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CAB925AC9
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0FF91F23548
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 11:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA43C17D889;
	Wed,  3 Jul 2024 10:52:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703F117C9E8;
	Wed,  3 Jul 2024 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003945; cv=none; b=NukmpLtzoLyt8GCIqOdpYYuplywOMSa8V+mHHgeQh8J0DKV4UaXuiJvgf/h1GGCwWAaCrAhwhCccifRQfeLgeznJH0IcXoj/98OE7qFGIH1vfObfemi/q4O+FCquufCfYdbjOwvuGNrOGiLyepP8SlET4R1qadwBbVC+Us/drBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003945; c=relaxed/simple;
	bh=WF4dYoXfQmXQ/KbPoJjm7XmgLWMMQrwDNEFvcWgVF58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/PlrlBMjvQgNrSJe8uXkin2fE6TaKv0vkNc3omD7Qd6cBCTljPybzdBBM7NHuX4MlIece++Gp1oFwkmY5eh7fNupI5EiM91Bot/NuUepPrwF1IdxAh6wgHcMvTFTbXe6EBXWun4w066baSJE3HcxovCuYOiRAgVrj/vniFv5rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sOxax-0007PL-VY; Wed, 03 Jul 2024 12:52:15 +0200
Date: Wed, 3 Jul 2024 12:52:15 +0200
From: Florian Westphal <fw@strlen.de>
To: Hillf Danton <hdanton@sina.com>
Cc: Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+4fd66a69358fc15ae2ad@syzkaller.appspotmail.com
Subject: Re: [PATCH nf] netfilter: nf_tables: unconditionally flush pending
 work before notifier
Message-ID: <20240703105215.GA26857@breakpoint.cc>
References: <20240702140841.3337-1-fw@strlen.de>
 <20240703103544.2872-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703103544.2872-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hillf Danton <hdanton@sina.com> wrote:
> Given trans->table goes thru the lifespan of trans, your proposal is a bandaid
> if trans outlives table.

trans must never outlive table.

