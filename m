Return-Path: <netdev+bounces-195355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 434F6ACFD6F
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 09:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6457188A526
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 07:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDB82040B6;
	Fri,  6 Jun 2025 07:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="FPhu2FQk"
X-Original-To: netdev@vger.kernel.org
Received: from sg-1-11.ptr.blmpb.com (sg-1-11.ptr.blmpb.com [118.26.132.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E1D149C7B
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 07:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749194671; cv=none; b=eghlghkXxugUsostHVKDW7eQ4OBLRG/vs82nWIU6N01/JWNKFqtzUH+zL5cwhCj8a3xzbMUnSdWdDNXR2G84WJESr8ljF4f8uVl8/T0j0O52cjwWyobyUo5woaieTnA7Bzv+xDFE+cZ79dX38o535R7tRg21e39e0RdlgXlE7kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749194671; c=relaxed/simple;
	bh=ccafHMnygaW6vo5XsqPyrNWgWL3f0MGNQum3uzNrE5g=;
	h=In-Reply-To:References:To:Cc:Mime-Version:From:Subject:Date:
	 Message-Id:Content-Type; b=e+5buqppCjDkgi2hYxxy7ionwZ5eFN2J++4cRFz9IkGiXd26rksS202xKXXhxzHi/J8pk2jl2zliS6rrUwcJY5PfEYOUYxc37lKtHgzsETyPO3d4Rp+cXMBbY1OdYS2OzB3ETaBs6rVRIj1zql1mmjwdM0YREasJ/+kUnZraIZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=FPhu2FQk; arc=none smtp.client-ip=118.26.132.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1749194661; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=G7QbOBFbxh5v/2LEN4d4Q6UgVXO16QJCvW2JiPdhBwI=;
 b=FPhu2FQkpQNZDrv7kbdW6TRGHmOt3RLPZxN+234wP6kFoNwoEAY8PCsq4paYl0Syk8GAet
 7ViwiKuFHXCwB2vBDmhy7qpOkeVbF5Ys7OLPs86O5VXmwg5LTFIllgiLQBuIpv2P3cYeQJ
 ypBZwfqC/iDFUugO4V8rc+0Oy41eElxLTpWg13rpKSJoOvupu+lXT5DJhxyx/6d1V4oIiM
 ED6ojxxnyoCNByCYIXH9WlWmsJ8hDvY2VbePWCKhKoCe9VLhMCmZQEpcF7N6koiS7eI8Dj
 gXHddjw2oJshiw8AhbJNB5gkOlrV1t3H5mZklLSxGjwfihnEYYPdcot357bi4Q==
In-Reply-To: <20250605065615.46e015eb@kernel.org>
References: <20250423103923.2513425-1-tianx@yunsilicon.com> <20250423104000.2513425-15-tianx@yunsilicon.com> <20250424184840.064657da@kernel.org> <3fd3b7fc-b698-4cf3-9d43-4751bfb40646@yunsilicon.com> <20250605062855.019d4d2d@kernel.org> <CAMuHMdVMrFzeFUu+H0MvMmf82TDc=4qfM2kjcoUCXiOFLmutDA@mail.gmail.com> <20250605065615.46e015eb@kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>, 
	"Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: <netdev@vger.kernel.org>, <leon@kernel.org>, <andrew+netdev@lunn.ch>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<horms@kernel.org>, <parthiban.veerasooran@microchip.com>, 
	<masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>, 
	<geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+2684297a3+965e35+vger.kernel.org+tianx@yunsilicon.com>
Received: from [127.0.0.1] ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Fri, 06 Jun 2025 15:24:17 +0800
From: "Xin Tian" <tianx@yunsilicon.com>
Subject: Re: [PATCH net-next v11 14/14] xsc: add ndo_get_stats64
Date: Fri, 6 Jun 2025 15:24:17 +0800
Message-Id: <abe7daba-e636-4ab1-a79e-f451db5d56c4@yunsilicon.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
X-Original-From: Xin Tian <tianx@yunsilicon.com>

On 2025/6/5 21:56, Jakub Kicinski wrote:
> On Thu, 5 Jun 2025 15:39:54 +0200 Geert Uytterhoeven wrote:
>> On Thu, 5 Jun 2025 at 15:29, Jakub Kicinski <kuba@kernel.org> wrote:
>>> On Thu, 5 Jun 2025 15:25:21 +0800 Xin Tian wrote:
>>>> Regarding u64_stats_sync.h helpers:
>>>> Since our driver exclusively runs on 64-bit platforms (ARM64 or x86_64)
>>>> where u64 accesses are atomic, is it still necessary to use these helpers?
>>> alright.
>> [PATCH 1/14] indeed has:
>>
>>      depends on PCI
>>      depends on ARM64 || X86_64 || COMPILE_TEST
>>
>> However, if this device is available on a PCIe expansion card, it
>> could be plugged into any system with a PCIe expansion slot?
> I've been trying to fight this fight but people keep pushing back :(
> Barely any new PCIe driver comes up without depending on X86_64 and/or
> ARM64. Maybe we should write down in the docs that it's okay to depend
> on 64b but not okay to depend on specific arches?
>
> Requiring 32b arch support for >= 100Gbps NICs feels a bit hard to
> justify to me at this stage, but I'm happy to oblige if there are
> reasons.

All right, I'll moidfy the depend to:

     depends on PCI
     depends on 64BIT || COMPILE_TEST

Thanks,
Xin

