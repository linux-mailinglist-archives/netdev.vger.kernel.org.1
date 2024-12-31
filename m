Return-Path: <netdev+bounces-154623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4B99FEE59
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 10:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAC127A14AB
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 09:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CA11891AA;
	Tue, 31 Dec 2024 09:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="NhWd7R1b"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-60.ptr.blmpb.com (va-2-60.ptr.blmpb.com [209.127.231.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E3F23CE
	for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 09:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735637502; cv=none; b=qKkoKswDAJxelKZufvG3AFmxTkzOEQ0kdARNxIkeL8rzta8lT21hANiBIfeFqxZ9BP/XrSumF4MXUEdnDwpH2V9tmLTZrChj1D5le/tC4iWbv/XGF9wIxqZ/1Elbn2TPUTczslKHHJDA3nQa6CzwWnWN0yoRtVMg3u9p5HGnIjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735637502; c=relaxed/simple;
	bh=erf0Qk388AfiJGaK4DoRdVVoO/Bf1Yp60NmgHm2fA6U=;
	h=To:In-Reply-To:Cc:From:Subject:Date:References:Mime-Version:
	 Message-Id:Content-Type; b=rIT5pvEQVZa8+qgivCTsrziNKBWmnlActEwIeeuzILHLjFBmlGd5CWQ4Q2SFI16pAThJ4pHvHDfPbexZQe8cR5M80AsVAaGhwVBalf4RrjL3kxz19uUlLGaqjIy33Kog1VVs2U2fdDqjCZQMu7te93J+k2nrOYg6TaqRBDNI3JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=NhWd7R1b; arc=none smtp.client-ip=209.127.231.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1735637332; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=3fYgGQhdpYbLhjEk9EtFqVrK9eKUX6nYpAsIRyPsGL8=;
 b=NhWd7R1b3seB5sr63RRJwO45ZWxaH567j6aCSExAO2vqFJozy1GIfyEl9/6VSdPWcwTvZH
 +rke4hcKdqmhbMQIEUKbLs9QOavyyNCMkXK5TrGDh9/HLh9rERgVMD2PufH8uH7nzjvJ81
 J/2ReiBEc8X5bNNZs35V5knmr56Oe9/traXWSlsHbvjw76BXOkr6LFzk1PvCynS+8hXv2o
 mvduzdf/6OGC6ljM9B00xphbh22DQnn2zJXSdrxQt4IzeTflVaGGHEFgKWsno048QnJGUJ
 SjSQJ+oDtjCmminfeJmZS/e7kRCiQn6gL9vm0oZheSeEBX2CzcpuUUf0J0peLg==
To: "Andrew Lunn" <andrew@lunn.ch>
In-Reply-To: <45dfc294-76d8-4482-b857-4e3093ac829d@lunn.ch>
Cc: "Xin Tian" <tianx@yunsilicon.com>, <netdev@vger.kernel.org>, 
	<andrew+netdev@lunn.ch>, <kuba@kernel.org>, <pabeni@redhat.com>, 
	<edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<wanry@yunsilicon.com>
From: "weihonggang" <weihg@yunsilicon.com>
Subject: Re: [PATCH v2 08/14] net-next/yunsilicon: Add ethernet interface
Date: Tue, 31 Dec 2024 17:28:48 +0800
User-Agent: Mozilla Thunderbird
Content-Transfer-Encoding: quoted-printable
Received: from [10.211.5.55] ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Tue, 31 Dec 2024 17:28:49 +0800
References: <20241230101513.3836531-1-tianx@yunsilicon.com> <20241230101528.3836531-9-tianx@yunsilicon.com> <9409fd96-6266-4d8a-b8e9-cc274777cd2c@lunn.ch> <98a2deaf-5403-4f85-a353-00bfe12f5b13@yunsilicon.com> <45dfc294-76d8-4482-b857-4e3093ac829d@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: weihonggang <weihg@yunsilicon.com>
Message-Id: <47ccdbc0-765c-4b43-b347-f7c3bf047e39@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26773b952+dbe554+vger.kernel.org+weihg@yunsilicon.com>

=E5=9C=A8 2024/12/31 =E4=B8=8B=E5=8D=881:12, Andrew Lunn =E5=86=99=E9=81=93=
:
> On Tue, Dec 31, 2024 at 12:13:23AM +0800, weihonggang wrote:
>> Andrew, In another module(xsc_pci), we check xdev_netdev is NULL or not
>> to see whether network module(xsc_eth) is loaded. we do not care about
>> the real type,and we do not want to include the related header files in
>> other modules. so we use the void type.
> Please don't top post.
>
> If all you care about is if the module is loaded, turn it into a bool,
> and set it true.
>
> 	Andrew

 =C2=A0Sorry, I checked the code,rdma module(not in current patch) will use=
=20
the veriable=C2=A0 and turn it to real type=E3=80=82so it can not turn into=
 bool type=20
instead=E3=80=82Any other suggestions?

