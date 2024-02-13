Return-Path: <netdev+bounces-71332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2657F852FF9
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 13:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90661F23D34
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 12:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43A7381D5;
	Tue, 13 Feb 2024 12:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=online.de header.i=max.schulze@online.de header.b="ZXz0okeY"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666CF374E0
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707825604; cv=none; b=Q4782C+ovAhcBuK2d+RkT4ltGNElcujLQB4wZx/VfYKci/Tm61Pqmo9bEaDNlcun2c+ridEetqyf3fNHtEP5l/ITwGFbgx5+lvUsRlVBHYsjOuFG3JH/ZHZh/07g1dgFsSXZkS+JqJ4W3VjPSWZdtcBnpniWDIAdVXCM7ev0b5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707825604; c=relaxed/simple;
	bh=NQBuGcQ0ujIKwl4wDJtgdCgL7Ra9xt2fUxyZ925hvsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V6oJGMMQtr8Xg261WdVO7pyXScLEJYcN9enAbwgoGx1GWEDsw8TpxHRaRsY+2tRqqhdiIG9XgW9zstNLv50JS0Lvq0zWXd5Xlb0rdfdLxp07tYtiJg3doZl2cjLg4+eZOC+bZY/2WFhrfg8m0ReZW3c2oczKA009BpdmIht3tzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de; spf=pass smtp.mailfrom=online.de; dkim=pass (2048-bit key) header.d=online.de header.i=max.schulze@online.de header.b=ZXz0okeY; arc=none smtp.client-ip=217.72.192.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=online.de;
	s=s42582890; t=1707825579; x=1708430379; i=max.schulze@online.de;
	bh=NQBuGcQ0ujIKwl4wDJtgdCgL7Ra9xt2fUxyZ925hvsQ=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=ZXz0okeYCnhESc4YnzvrN+5kcXyQWWWXDw8EUBHXVhTWAA5sUpJWhBeTZoW9eJ5s
	 IvQW836/lWKTMr+o/oWZURB/z+NbebQqTTxJNGEjyF5QKamMiPP4EPQAcAfwJX308
	 Ou6+QcIEJj6lu5ax59KcmEV498toDxgcTPu/p0detdAePK/r5e1p8FEPSQo+OIZ4T
	 zM2Qmi1mvlaqXZRYefXxPSW5ffUp+9q8DdY+EBr7mMhIvwtv4FNqfuO7fOAdYXeR3
	 nIycQbtbfF4E7C1J76PKroQkEmBBVLlXsTWSemqpS8ocI9gFZ9DnaqzlDvr2OXhTA
	 sHkSAK7dfVSRRaBqnA==
X-UI-Sender-Class: 6003b46c-3fee-4677-9b8b-2b628d989298
Received: from [192.168.151.38] ([84.160.48.104]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MLi4c-1rIBx63eqW-00Hf9d; Tue, 13 Feb 2024 12:54:04 +0100
Message-ID: <71ec8c74-270e-41f6-b336-0198b16dd697@online.de>
Date: Tue, 13 Feb 2024 12:54:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] tcp: allow again tcp_disconnect() when threads are
 waiting
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, gregkh@linuxfoundation.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, tdeseyn@redhat.com
References: <f3b95e47e3dbed840960548aebaa8d954372db41.1697008693.git.pabeni@redhat.com>
 <169724162482.10042.15716452478916528903.git-patchwork-notify@kernel.org>
From: Max Schulze <max.schulze@online.de>
In-Reply-To: <169724162482.10042.15716452478916528903.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eFI3H+fDhz/sz1yFlbC8su2JdOEO42siWn/wc6r7fpHLxUX5Cxe
 JAenCTulpT6C2P2agj0VTBuWl7RDIaXN8hmIr872+RnFTNIVOgpo9gfITDcyf+L1XZYXUv2
 QB6hjIucW4tVX8jnAU/Bu7oaEpNkM7kplW6aqFO3fuiqFfVIgzyr4lZX0GOQcIhuFpjZfGT
 cFyhak4toa8xfI2izLokw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jjvrlPBORVU=;xsTM0rObhZHVZD7L/EhNKBLsRdJ
 2ku6sdHHhSQVyFR7bPuyumS1E1/6f1DIdc/WfKsaCB4655SNQjTc/pp0VM3JfpQB8BBNG/r4u
 h6sFTdfytJrNz0RWpfQSIh1ILxiTwOpZ6EeMms2z4pjNEvVIT0ExxCUSTMmwwGy0ZB7/CWDEg
 gF8stMGPELn3t0gv2zGLVHV/C2A9OG29vjlemiED7j/muCHJgOzWhC3W7+wyVrL5U95Hze4gl
 I+oMuJl3lXnkBuCLt/D08PF1fluUIgQhxuj9fTicFZsfHK63lG+gtrCpqQz103jtubfZVGpEY
 n7csV+xPkgYQ9tsfLw6wO1bjJZyKdH+b9DQEe6sV6rS/BHaFhPQeEoIoQSPsbQiclW9laU6DJ
 imI4XE7r2tnuRuuWg7u3KFr2RBmBxP1cLY1FOCV4SLV2eqV5uCGzf8/MFFdt1wj1g1umaSUnv
 u7u3e7AHCTKO09hLdjW5BDOXKlvQ9ACuYB7W3f7k5AkKWWgl40JMvn8aRXUFM9uY30LkQM5u6
 TsbQ+RJ2fAcwtt4gDPCnYB6lIPrFoVThdgVibYyFE7kOp858vVVnimrdNiw0WTOC9yw7fyDDj
 pJvU4a/kZG7e6bO/1yeiPwdbcw9V7AgutFEDkCeHFIUkvqvrVfbX4+h+kV+1esKLDYB6fxlZe
 zaIYfvt8rV7GCxCHE1N5eba5XHTSluwEGFAhOadWqfMtG2td4L/ktcv7H2G197Tcm8WAauCrp
 7WRKqdftjTWARSoBZULItjNibNBEdpxcF+hg/5tOm/HQPOTkF0Us68=



Am 14.10.23 um 02:00 schrieb patchwork-bot+netdevbpf@kernel.org:
> Hello:
>
> This patch was applied to netdev/net.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
>
> On Wed, 11 Oct 2023 09:20:55 +0200 you wrote:
>> As reported by Tom, .NET and applications build on top of it rely
>> on connect(AF_UNSPEC) to async cancel pending I/O operations on TCP
>> socket.
>>
>> The blamed commit below caused a regression, as such cancellation
>> can now fail.
>>
>> [...]


Hello authors, Gregkh,

it looks to me like the breaking commit

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/ne=
t/ipv4/tcp.c?h=3Dlinux-4.19.y&id=3D0377416ce1744c03584df3e9461d4b881356d60=
8


was applied to stable, but not the fix?


https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/ne=
t/ipv4/tcp.c?id=3D419ce133ab928ab5efd7b50b2ef36ddfd4eadbd2

Could you consider applying the fix for 4.19 also?

