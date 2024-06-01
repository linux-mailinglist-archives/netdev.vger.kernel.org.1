Return-Path: <netdev+bounces-99894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EED8D6E64
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 08:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 001161C245AC
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 06:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2573125AC;
	Sat,  1 Jun 2024 06:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="bV5vfO7s"
X-Original-To: netdev@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95A81C683;
	Sat,  1 Jun 2024 06:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717222635; cv=none; b=ti0E8sdT4ENZCyyg6H+PQVKoM53w7SPTy7+QIF1TEh1UAHYLjOIea/QOgnar/NideRclHltuoXzyrA0FoksPeyKIIHJSgkHKJHlJr5eb1lFfvE5DiPmvCB+n1I83z7ro10HvlmpvHQhskcxYzLi5LLC6mJIiqrbFXQwOtfL4YoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717222635; c=relaxed/simple;
	bh=Gz7bmF9TUjc/OX2Bwz5if/Zl49asSXtO5AF+/IhGghI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XzVTmfEzLqNcj2OdePwr4nnz3ImH/awsI0Pz3FcafsyW8MJCo/kMOQ89fwnVMDzJf/8+hhaVYhZXGQNusDjxqodCXaVCShqKc/2wj4t+qL2o8XFvDBWUZUy06JYXVNUfLgzAdNk5kUb2IvRxEvc/TiJVIpOV1tdZxQuI7nYVtaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=bV5vfO7s; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=Gz7bmF9TUjc/OX2Bwz5if/Zl49asSXtO5AF+/IhGghI=;
	t=1717222633; x=1717654633; b=bV5vfO7sxu4CK+c2E1vKHFEbglE3nejA2LtLfnALd7I99l2
	/Y/LcKrWlfp5+7wYMP632GVCB9Ui/DosRhAyZTt0MXnW7FC+mK1hW78maRbZfUjkE+hvL37GDC9lb
	uM+ovc75j5VdEUQfFRTrCB8aeydjqgHcFq+31UDKAPVV/a0fGH58UhH0Yx2SULGWN8tvf0K6ak0QA
	R74xPIBu5DvgvwQoCQp54RTmeILE/7yCX76jg5o5+pZ6fPjJOrXkXiqRlQJaaN3SXMr0YXiPQMIlg
	QtHcCvOnKHmh5d0Y+winF7FpJOS1uaELRor9Qi7L3qS1SxDc0pTsct6alkA31gUw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sDI30-0004Ep-UR; Sat, 01 Jun 2024 08:16:59 +0200
Message-ID: <3abae158-adb3-4f76-abf7-6415740bdfd5@leemhuis.info>
Date: Sat, 1 Jun 2024 08:16:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Revert "igc: fix a log entry using uninitialized
 netdev"
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Corinna Vinschen <vinschen@redhat.com>,
 Hariprasad Kelam <hkelam@marvell.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Naama Meir <naamax.meir@linux.intel.com>, netdev@vger.kernel.org,
 Sasha Neftin <sasha.neftin@intel.com>,
 intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20240601050601.1782063-1-mika.westerberg@linux.intel.com>
 <20240601050601.1782063-2-mika.westerberg@linux.intel.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20240601050601.1782063-2-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1717222633;711b0827;
X-HE-SMSGID: 1sDI30-0004Ep-UR

On 01.06.24 07:06, Mika Westerberg wrote:
> This reverts commit 86167183a17e03ec77198897975e9fdfbd53cb0b.

TWIMC, Sasha Neftin already submitted a revert for that commit on Wednesday:
https://lore.kernel.org/all/20240529051307.3094901-1-sasha.neftin@intel.com/

Regression reports for this problem I'm tracking:
https://lore.kernel.org/lkml/CABXGCsOkiGxAfA9tPKjYX7wqjBZQxqK2PzTcW-RgLfgo8G74EQ@mail.gmail.com/
https://lore.kernel.org/intel-gfx/87o78rmkhu.fsf@intel.com/

Ciao, Thorsten

