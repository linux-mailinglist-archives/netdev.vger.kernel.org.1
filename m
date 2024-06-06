Return-Path: <netdev+bounces-101497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE878FF11F
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C58B41C2188E
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575DC197A76;
	Thu,  6 Jun 2024 15:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=schaecsn@gmx.net header.b="U2T/S5JR"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC10198A0A;
	Thu,  6 Jun 2024 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688847; cv=none; b=ZigOTfEJAllCQ5znOHKEZT/FOe0yegMoRHsF2eOqDUt3rrI+vC7Ok9UXHaXHNgbMNnskaAs9esII/RqsMN9DFCd4l3dr8yNJHRMo0LT6Y0DHmYAayR6Ah9e378O/8Jvd9wz/4z0XS2O71vtfT/mNXFoRNxEPAUn7K+xHV50pYB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688847; c=relaxed/simple;
	bh=QcDw2jc2BfZ+k/TbM/vd1C8TAW70hXP/jfMovjQ+yG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KXP6yaRB7zv2iyXT/WPhcdzRstvU10vKt7XHJgiUxm8lhNcJAQTFZ8txedTZ9rqo+Rp67ObkYhEYbDaAIFFzmv1352x3lTLc+XqVUOcy+sjbCkZLLjR0rEZ6IAxjD20Oz5vs9NFc71jQPcwiFNEppKDcF5t4iZRaw2iNaflDvt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=schaecsn@gmx.net header.b=U2T/S5JR; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1717688825; x=1718293625; i=schaecsn@gmx.net;
	bh=QcDw2jc2BfZ+k/TbM/vd1C8TAW70hXP/jfMovjQ+yG0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=U2T/S5JR+0SiGAsJWWnecKg7FYYQ8f+8yIcT03A/poLh9al5q7EpfB+4HR2K8i3S
	 oZMNiiuDB6as1VrNnS+hIk3Qs1UViKD/S8mKt4z0eZluVeC9GdPtREV89IwCeiZbR
	 AGiDr7D8Sl5/GKvfFi+at37HjxRt3EDU92O7nWU+N2BhRoNy4xaNn9J4+W8VBOVWy
	 /8887KtAdsSgUJqAofYtfUJgdAfFlZNKrQOkFBVznw/YceAv32V2IX9uhywR3tMfL
	 RjQV1QOQetaeI7EkPqOlDrONjMyv3h6AzrEkxsO5SfDUMHhFbbUlH5vF9gOpMA2Ls
	 +Ya496qxHiHzFt3q6g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.209] ([173.228.106.93]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5wLT-1sM60x1tYB-00AKLE; Thu, 06
 Jun 2024 17:47:04 +0200
Message-ID: <70d92f17-d9aa-48c0-a132-506faf6f94dd@gmx.net>
Date: Thu, 6 Jun 2024 08:46:58 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] igb: Fix igb_down hung on surprise removal
To: Ying Hsu <yinghsu@chromium.org>
Cc: netdev@vger.kernel.org, grundler@chromium.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
References: <20230518072657.1.If9539da710217ed92e764cc0ba0f3d2d246a1aee@changeid>
 <5184214b-22ed-41cf-a1b0-6db2d4ff324c@gmx.net>
 <CAAa9mD1HGJDKzoLoqZzyrR5wsk_6voWs+VmoZoo9ZontyvjUww@mail.gmail.com>
Content-Language: en-US
From: Stefan Schaeckeler <schaecsn@gmx.net>
In-Reply-To: <CAAa9mD1HGJDKzoLoqZzyrR5wsk_6voWs+VmoZoo9ZontyvjUww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RmkEobG8qViO5ZiTlBvaeaBpYAXSsAocvTIYWQATG91O5FsnEPF
 naNXMtLGd0+K0AIT0P4dEDFW1lysZS7X3IZ/cSfR24LbftzMuQlFsNIgy1Hety/+P2WyutL
 o5o98aBKQ3lwBnyrFnDVDxVoLlT0QMr1qq7+wbY/C5ffqYlxOwQiBa+ptFFFDFG0vPPrqPW
 XdgK+alTkrPl3ZKcwo3Mg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/+v8FRrhYKg=;AjlZ+spZRlHkTBGo1MORJrN9CJR
 yR8tJV/Yv8WZRm1KTu82pixM/xa9d0iev8SB8fMGQSeQA3mxwd6mABcFO0MVTTCAsrOcQAA0T
 h0aK9wT2Q/bAP6WPwW3Jcojsn5I0jM75tpwe8sBXWWt6IzE0FtX949Cru4B9ArgaHj1+klGBm
 SiTzHqevrgu5QJal6B54+YAfORngMMy/Ql4aXazSQyWHW3ChHqbRD6QyQnO5rCUrLCpDFAzxr
 rTg3i1+BAyLJ32o4CPqxJbs085GPHIn6RclmwjeZofCtuJlsuyAG6QBhfPfy0QH1QXC8eQjhQ
 aj9+r9aZE2rYGrjNcu5S41vOK67o9VrHPe6A5EJFEIzyggCbHw0krcg/lCQ8x2MH2B0Na5kaA
 o3tM/P21Qs3kMqQShg1zkeG9p86jeuVSsh9+kbzM4DPrrxnlS+XUIkeZ6Ys7QiQgQ9nH9Zjdm
 SATQHcbZA5fMSMBo5CcmgW4hlmmQV6qTgk+JGcX+4+DQIHtK9iUtumi+IFeK2cDEpPjRg9a6U
 ptSfd6gHc3hUmCUjsINeAC/iaQVf87h2HtUrPu0wt28JemX9rdeVuaLxAwXJqyZ2paLy2XlCO
 zb6X/MaIPKz3b3rRAyNpo4GoYU3Fk94QbZDAMhRmAFNxQxX8QMQ2o+b/BBIMULr0UKSep3Jxw
 v9kBD43HDsG8Q2Pk2J1KRLKceQfHsKn2JvLW3b5D7cg6tfRitrDzUMi8G/sUYqRUHfqFNHub9
 z/8viftYEgcEwRCn/6rJvXcQRXI+AsoHWnxxADI/LHxz8gzBAgeRR1gId2+8zL+u0T3nO+iAC
 2+sjgUE3ePunsWCWDGJLAmrk/ySRcsRMdwOhR7OWJ0xtU=

Hello Ying,

On 6/6/24 01:03, Ying Hsu wrote:
> On the CalDigit Thunderbolt Station 3 Plus, we've encountered an issue
> when the USB downstream display connection state changes. The
> problematic sequence observed is:
> ```
> igb_io_error_detected
> igb_down
> igb_io_error_detected
> igb_down
> ```
>
> The second igb_down call blocks at napi_synchronize.

=46rom the backtrace in your commit message, I gain the impression you get=
 a hotplug event for removing the ethernet device. From your commit messag=
e I gain the impression you get an AER as well which is handled in igb_io_=
error_detected()/igb_io_resume(). The problem lies IMHO in the interaction=
 of both.


> Simply avoiding redundant igb_down calls makes the Ethernet of the thund=
erbolt dock unusable.

I'm not too sure if the current code is even perfect in your use-case. Wha=
t happens when you get an AER on the ethernet device (without plugging it =
out at the same time)?

Can you try to AER inject a completion timeout into your ethernet device, =
similar how I showed it in my previous message? Just replace the bdf 09:00=
.0 with the bdf of your ethernet device. I expect a kernel crash like we s=
ee that on our embedded system.


> If Intel can identify when an Ethernet device is within a Thunderbolt
> tunnel, the patch can be more specific.

 Stefan

