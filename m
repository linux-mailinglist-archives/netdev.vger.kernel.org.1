Return-Path: <netdev+bounces-180049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F39A7F47D
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 07:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 654517A3134
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 05:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109D625EFB8;
	Tue,  8 Apr 2025 05:58:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80831213E67;
	Tue,  8 Apr 2025 05:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744091919; cv=none; b=eae3inYPESeei0ZW0BfYUm+HqEQewdjFqu6O8CWMfEG2ovr9eIjy3rJS9S5mBZOSFExXqRWPwM2Cf1savN0LfIDpf8PR6A+SdVRW/CPNertfGu6gG33sGebmVPeRLcNB3GnRhr1lrkU6yFhJbPs7o/yzqHJhwBElRijIwrFpOhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744091919; c=relaxed/simple;
	bh=W94j31G+r8Y0Cd8KcgC93GsP943xgufSZZHy829yDhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oaxl3ZO6GU1cdrvOlUOH+d/t2hckT229XSKifUIuBg5wMDs0RbXazIPJ7s1GYhbpMWNIwEOnJKnfYanCp+hoNtwxWBybIljrFzJBYqFQuVAl26ozkmrzq1LO8tkj4S4bfv+oiWZKlGy5ZKSK9dTX76OCnem5/PFTZsyX/d9G5A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 96D1F67373; Tue,  8 Apr 2025 07:58:30 +0200 (CEST)
Date: Tue, 8 Apr 2025 07:58:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: hch@lst.de, axboe@kernel.dk, gechangzhong@cestc.cn, kbusch@kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org, sagi@grimberg.me, shaopeijie@cestc.cn,
	zhang.guanghui@cestc.cn
Subject: Re: [PATCH v2] nvme-tcp: Fix netns UAF introduced by commit
 1be52169c348
Message-ID: <20250408055830.GA708@lst.de>
References: <20250408050408.GA32223@lst.de> <20250408055549.16568-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408055549.16568-1-kuniyu@amazon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Apr 07, 2025 at 10:55:27PM -0700, Kuniyuki Iwashima wrote:
> Which branch/tag should be based on, for-next or nvme-6.15 ?
> http://git.infradead.org/nvme.git

nvme-6.15 is the canonical tree, but for bug fixes I'm fine with
almost anything :)

