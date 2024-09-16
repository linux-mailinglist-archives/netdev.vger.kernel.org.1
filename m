Return-Path: <netdev+bounces-128498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342EB979E8B
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 11:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6640E1C22B57
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 09:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B419F14900B;
	Mon, 16 Sep 2024 09:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ja+hxe/u"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8CE1487D6;
	Mon, 16 Sep 2024 09:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726479436; cv=none; b=YIuLo5y4EfCz7C2wKSrzc0uO7UVt2zkhhqW7KSugAmg9EOxP0lh2y+NKVTFZ3YmfMYlOcckNFFOZkBha1yIvR5TIEUFYA9OdyhImXD0vEGb3g8nC4Kn37rmG9L76du++66yqEq0Nj1Mlz1pQCox0aluu05anh9KxPQkreQeoA1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726479436; c=relaxed/simple;
	bh=LFyg6f6lnBdABg4ydokv21eDsJGTPr+Bw9Q7CKk6GY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuIyGEPnttkm25XJR1qvYTuVE3MJHt78LpEAYjQbn1TF2Exs84ptP2Y2aUKEQ+X+tF77OtUG7WVihHt/ARP56F+V6Jg5tyDY+RZOt2iJjC+1dGaHGiXealpnVVMSZguLVd02ATIkx0KdbVg/eEJsCdJeA6hDCUKQ+lj7K9Mqoqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ja+hxe/u; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Jy/uSXxDhY1rKDVJ6z7Vux15OXIdWeFq0dxU2LqcSNI=;
	b=Ja+hxe/u5pB6NuFBpfWoOCeRrL8KnVjOUAgPRfQvfKmublO8YX/8D+AGsWwUmw
	z6AAjHYc3FsYdQzYESfWoB5KZocCOkxcYKh1OM07lXVTyneiP5IkQezv7kAOKG6v
	IDy7DthgJ7pTV4un+3gW/mV7XCiTg0hI+sGJ4a6Zl53AM=
Received: from localhost (unknown [36.56.252.231])
	by gzga-smtp-mta-g2-5 (Coremail) with SMTP id _____wDnCDs1_Odm2FQdHg--.28295S2;
	Mon, 16 Sep 2024 17:36:53 +0800 (CST)
Date: Mon, 16 Sep 2024 17:36:51 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Ahmed Zaki <ahmed.zaki@intel.com>, intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [Intel-wired-lan] Is this an out-of-bounds issue?
Message-ID: <Zuf8M0eh7AuQ0Zks@debian.debian.local>
References: <ZuQ6aCn7QlVymj62@iZbp1asjb3cy8ks0srf007Z>
 <c9c582a2-2d72-4258-ad67-8d159cf256d6@intel.com>
 <b7dabc2d-19a4-42f4-ba5c-31e1803d821a@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7dabc2d-19a4-42f4-ba5c-31e1803d821a@intel.com>
X-CM-TRANSID:_____wDnCDs1_Odm2FQdHg--.28295S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVs2aDUUUU
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiRRtcamXAo9AW6gAAsC

On Mon, Sep 16, 2024 at 11:19:32AM +0200, Przemek Kitszel wrote:
> ugh, sorry, it's already public:
> https://lore.kernel.org/all/20240823230847.172295-1-ahmed.zaki@intel.com/
> 
> awaits our VAL

OK, thanks!

-- 
Best,
Qianqiang Liu


