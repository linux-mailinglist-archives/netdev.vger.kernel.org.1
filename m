Return-Path: <netdev+bounces-60996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E978221B3
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 20:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F11DC1C226EA
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 19:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057CD15AD2;
	Tue,  2 Jan 2024 19:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=corelatus.se header.i=@corelatus.se header.b="luJtMjoE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="z+DIMEfV"
X-Original-To: netdev@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7359315E95
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 19:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corelatus.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corelatus.se
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 4920F5C010F;
	Tue,  2 Jan 2024 14:06:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 02 Jan 2024 14:06:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=corelatus.se; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1704222372;
	 x=1704308772; bh=TuKAXUl/X2uk7hHWIkbpgwu/c7RmjvxjmFC1QCR+lM8=; b=
	luJtMjoEvCnPBp0KkFvCSxNUmz4Sfpc4tvkk463HWBEVB0miIQkjlOHoq1WgokpI
	lZEv8a1QtP/UqLOVexJcIo5HPl8xgaenKM11iEw9AI4fuKJ+NJvwnjda7KR7FP20
	7Lk2h3eNbCdlsNLZfN1I+GJyDdj4GpLAtL3V4t4ev4kvBsso3amxS0+qdIRWt+a9
	CgiW5GY/aEkABphK14XomexNRogOdks+fsIsvYb2YdLk2W6D6RRAOOgRSLGNKWgZ
	kURn4jK9ZxxbSomI6s3irXtXpeULKe7lIdukIe7MRAH9QtiLdbUrtNInvG1bCstM
	JsPSIuQHKhR6owqjN54ACg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704222372; x=
	1704308772; bh=TuKAXUl/X2uk7hHWIkbpgwu/c7RmjvxjmFC1QCR+lM8=; b=z
	+DIMEfVY6LY8NkjEny9KswWSUhQUd0V//FKIFDCq3gU+WQBRJWSiDfa2RhZX0Mef
	F6OV5VQasj9cdRpAWKPwLxw5jm0toiH65VLQCjvnEbjZkR/71LHIJWxOKuj5oUxG
	hvwik4nE+IBWcPUhDs7MCIy653dk0iPkPrQs8hUh1E21QWSElNlLzyGHQPmiqAbx
	nBEBtxLl3mEx+crpl6usc+gEJOxJXZmapC5LCHqNSMrREfFIpPQNVPm+FvE5iZcU
	Ne7i+QPkxFkIfJGIh7AtggSVUHpSSvtD6z7agItm13wZb+juxndsBLGQcb10IMhF
	cc8N2GAaJzOa2Mjr1BNBg==
X-ME-Sender: <xms:o16UZfgNprA7AJBe6vyPPtgCTGTn5sTzFuZ45K2DSNDBJ-6f2ZD7FQ>
    <xme:o16UZcDe1p_oZeCJFgp-7-uuV7LEIt_tftG-FWudybwTtvMQDWOIFiJNfcRmvSpZ_
    WQT5qDYf2Lm-6we1g>
X-ME-Received: <xmr:o16UZfGv_epbld3TX_GrFyEn8tbl5qisDsfjWUx6pw6SonNvK0c92DfM0diEucRt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegfedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfuvfhfhfgjtgfgsehtje
    ertddtvdejnecuhfhrohhmpefvhhhomhgrshcunfgrnhhgvgcuoehthhhomhgrshestgho
    rhgvlhgrthhushdrshgvqeenucggtffrrghtthgvrhhnpefguedvjeetvdelffeiheeige
    eljeefjeehvdejuedtledtffetffdvteegffffieenucffohhmrghinhepkhgvrhhnvghl
    rdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthhhohhmrghssegtohhrvghlrghtuhhsrdhsvg
X-ME-Proxy: <xmx:o16UZcTbJW8nsuLCNTUg4G1zFS9t30zh43fn1w57TeuUkLfA5L-5Lw>
    <xmx:o16UZcxuhCMaYhKkFoX8eN9ETEi11hJglABU39_4-hbEdmvAVebGyg>
    <xmx:o16UZS4R5af44yqGcOfxNlhEXQcI3Vgm8UsRKLNO1-54sgrn_zJkdw>
    <xmx:pF6UZWvsPCbnSdhrc0cEpAQRMjV4uVCAQRBmBQUwqE1KZtdNVg_WIQ>
Feedback-ID: ia69946ac:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jan 2024 14:06:10 -0500 (EST)
Message-ID: <dc642c69-8500-457a-a53e-6a3916ef6dab@corelatus.se>
Date: Tue, 2 Jan 2024 20:06:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: net/core/sock.c lacks some SO_TIMESTAMPING_NEW support
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 netdev@vger.kernel.org, jthinz@mailbox.tu-berlin.de, arnd@arndb.de,
 deepa.kernel@gmail.com
References: <a9090be2-ca7c-494c-89cb-49b1db2438ba@corelatus.se>
 <65942b4270a60_291ae6294cd@willemb.c.googlers.com.notmuch>
From: Thomas Lange <thomas@corelatus.se>
In-Reply-To: <65942b4270a60_291ae6294cd@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024-01-02 16:26, Willem de Bruijn wrote:
> Thomas Lange wrote:
>> It seems that net/core/sock.c is missing support for SO_TIMESTAMPING_NEW in
>> some paths.
>>
>> I cross compile for a 32bit ARM system using Yocto 4.3.1, which seems to have
>> 64bit time by default. This maps SO_TIMESTAMPING to SO_TIMESTAMPING_NEW which
>> is expected AFAIK.
>>
>> However, this breaks my application (Chrony) that sends SO_TIMESTAMPING as
>> a cmsg:
>>
>> sendmsg(4, {msg_name={sa_family=AF_INET, sin_port=htons(123), sin_addr=inet_addr("172.16.11.22")}, msg_namelen=16, msg_iov=[{iov_base="#\0\6 \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., iov_len=48}], msg_iovlen=1, msg_control=[{cmsg_len=16, cmsg_level=SOL_SOCKET, cmsg_type=SO_TIMESTAMPING_NEW, cmsg_data=???}], msg_controllen=16, msg_flags=0}, 0) = -1 EINVAL (Invalid argument)
>>
>> This is because __sock_cmsg_send() does not support SO_TIMESTAMPING_NEW as-is.
>>
>> This patch seems to fix things and the packet is transmitted:
>>
>> diff --git a/net/core/sock.c b/net/core/sock.c
>> index 16584e2dd648..a56ec1d492c9 100644
>> --- a/net/core/sock.c
>> +++ b/net/core/sock.c
>> @@ -2821,6 +2821,7 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
>>                   sockc->mark = *(u32 *)CMSG_DATA(cmsg);
>>                   break;
>>           case SO_TIMESTAMPING_OLD:
>> +       case SO_TIMESTAMPING_NEW:
>>                   if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
>>                           return -EINVAL;
>>
>> However, looking through the module, it seems that sk_getsockopt() has no
>> support for SO_TIMESTAMPING_NEW either, but sk_setsockopt() has.
>> Testing seems to confirm this:
>>
>> setsockopt(4, SOL_SOCKET, SO_TIMESTAMPING_NEW, [1048], 4) = 0
>> getsockopt(4, SOL_SOCKET, SO_TIMESTAMPING_NEW, 0x7ed5db20, [4]) = -1 ENOPROTOOPT (Protocol not available)
>>
>> Patching sk_getsockopt() is not as obvious to me though.
>>
>> I used a custom 6.6 kernel for my tests.
>> The relevant code seems unchanged in net-next.git though.
>>
>> /Thomas
> 
> The fix to getsockopt is now merged:
> 
> https://lore.kernel.org/netdev/20231221231901.67003-1-jthinz@mailbox.tu-berlin.de/T/
> 
> Do you want to send the above fix to __sock_cmsg_send? 

Sure, I can do that. Do you want it sent to [net]?

/Thomas

