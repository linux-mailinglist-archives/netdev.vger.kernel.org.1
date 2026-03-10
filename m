Return-Path: <netdev+bounces-266211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDeiIPE5sGlbhQIAu9opvQ
	(envelope-from <netdev+bounces-266211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:34:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1DB253A12
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A93D318C701
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A732C1593;
	Tue, 10 Mar 2026 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqvM0r9b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462D92E7637
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155151; cv=none; b=sWZtGdHBI/BpqfcdOiMJ/cWliHPilMtLvJ/V7shxiMs9pK34Vw/Y43MNq3zH2vStx2M41jjOKVY+q5/WKEqNtVjAINO2PQLofWPrJWaei2C12oDyNEOq4ALd2ft42mBBpE6q/KQtHedK72VIr9GHAHIl02sD5cQGPJ1rz4c8oQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155151; c=relaxed/simple;
	bh=4luFfURSSJ5bIcbNyeANzWAFxKOH2g6vfxc69uRys/s=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=Udgdx2Wpm/5kM/EPnINPgYaNrZZk7FjnrshKhrN0wklWoa6UR1quVqID63p/bL87jA2wltcFpZHK9+SrliOh0RNQqT7T/oC/EBQZMAl21ORf1so44Pc6gcL6XkVdcplKjr2PBwKCwsIYZApS5aRIXsCDjGqF5RLmTIb5Hd0Hun8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqvM0r9b; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b9382e59c0eso1107237466b.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 08:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773155149; x=1773759949; darn=vger.kernel.org;
        h=subject:autocrypt:cc:to:content-language:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4luFfURSSJ5bIcbNyeANzWAFxKOH2g6vfxc69uRys/s=;
        b=dqvM0r9bS2xt32TcvZlR2cgrR+4dEQZ723YBJbPCu4HbKlWUuxJiB7SfoI42UlaN4K
         LtOEJd42dRz3P5iKHdl9G4VgL8u9jUKjnHzIZ65T9GkGe+XAWGsQE2ix26ZC+1Gdgeky
         IdPcuQVr0xSpH1/ZzVz6rRihMfpYxsa85tKsvACjrgrxhsX0ca22bsU4wMFvgPgz3fHt
         q/TIGxCt2TudKQ81F8aBg5q5nmMsudJVrp1h1hZ9G/pQcQMkje0al8cQTP22Yyo0LcMV
         9XO8JbV4n/KdeKsNZUv76HjrhhQGFHNkPOceO8obfGPog2kfy5CGodMN0rEMTy+uK0fX
         IuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773155149; x=1773759949;
        h=subject:autocrypt:cc:to:content-language:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4luFfURSSJ5bIcbNyeANzWAFxKOH2g6vfxc69uRys/s=;
        b=g0CpNuWBXFZX4JfnDJhRgAegaRKoi6rbydChWiybA6u0+EZYpNJQCDGUzz/nWdR09w
         gtW8ES2WO9aentPGpNO9iBlhHOdk22oVGsenbxg8UQTz8DbxP6grfYf4izllXdzn696m
         unR4TOtwBI+I8g0pkEVvgwQYiXKcV7FgWDJShse0TYYNgXtIfAEbJsKpbC6YLnFSCyMd
         dJMHqHAOZkYx2MpPIIwy03sVtVSTOE4ooHGlyopBMiOlubvabOHnEVsaZCHH1wRIpgn0
         heKK9tjtKMIoiIvaeHdFuR6u4X/NQSch+ctgnT209iUzgdY92tl4nCWbVaHF51s9OlaC
         Y76w==
X-Forwarded-Encrypted: i=1; AJvYcCUL+NiXtQ0ksfeOtKmjV8bGRGbWobBlXBpfAN7c7B6V6oThUF4OYvjXL0N7ZbT4R2TTbBYGA+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnSCU506KilALrUsIfoohDpMBjqjXDgTnKyrOm2MSB9F5Xe146
	VJRQTx4GrahW4sW9MJpgb0gB6bEJdzBSnj6FZIHgEalmBjuP1otEnDPX
X-Gm-Gg: ATEYQzwhG7VGtTXszGWx1BECp0XWzG4+gCNYamTjDSW2YM1KIBCtwoLt1K5PtI3KiJ/
	eJVHu3s+Wp3UF+uJgUai7AzQLSr5LDZ76ILp8fSFIAfeeT8JAWPszekbzvOuG3KIpLZBQwJKxZO
	O3vfdX0pBJ6wosgEx4ghoDuQdVAIHAn2RNjxu0Vj1yKcYr94Dtt1KSu4WnwcGxd+Sv2LItJhiJS
	P6jvLqj2sBAc721yihd6bfm9J9Z/6r15IWhDP6aGjlywZvPNqBfi9dcXzzAg2cQxgLNy/GS73kA
	G1bLmxfcEQ7c/n2pwDYGI9BtWsVk66S9hr7t1lO/qPba0TRdNjDv32IcyRqzO4+uwkjlJ+h+A/6
	yQJnOeV9l3XLQJdqiNxz+vQ6FaPJAm+0hYFG4eKMiSWeObXn0+amYUf3t38rRX2mOve0i08vejh
	l+D7/HYTuKRiBoBPtASeJkqAGX+okWWg==
X-Received: by 2002:a17:907:3f15:b0:b97:1db4:e5a2 with SMTP id a640c23a62f3a-b971db504f1mr113759766b.39.1773155148187;
        Tue, 10 Mar 2026 08:05:48 -0700 (PDT)
Received: from [192.168.1.100] ([87.254.0.141])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b96da58b66dsm391695666b.42.2026.03.10.08.05.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 08:05:46 -0700 (PDT)
Message-ID: <299e76bf-6e7e-4332-a4e2-61698cf95c9a@gmail.com>
Date: Tue, 10 Mar 2026 15:04:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Content-Language: en-US
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Jiri Pirko <jpirko@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Autocrypt: addr=colin.i.king@gmail.com; keydata=
 xsFNBE6TJCgBEACo6nMNvy06zNKj5tiwDsXXS+LhT+LwtEsy9EnraKYXAf2xwazcICSjX06e
 fanlyhB0figzQO0n/tP7BcfMVNG7n1+DC71mSyRK1ZERcG1523ajvdZOxbBCTvTitYOy3bjs
 +LXKqeVMhK3mRvdTjjmVpWnWqJ1LL+Hn12ysDVVfkbtuIm2NoaSEC8Ae8LSSyCMecd22d9Pn
 LR4UeFgrWEkQsqROq6ZDJT9pBLGe1ZS0pVGhkRyBP9GP65oPev39SmfAx9R92SYJygCy0pPv
 BMWKvEZS/7bpetPNx6l2xu9UvwoeEbpzUvH26PHO3DDAv0ynJugPCoxlGPVf3zcfGQxy3oty
 dNTWkP6Wh3Q85m+AlifgKZudjZLrO6c+fAw/jFu1UMjNuyhgShtFU7NvEzL3RqzFf9O1qM2m
 uj83IeFQ1FZ65QAiCdTa3npz1vHc7N4uEQBUxyXgXfCI+A5yDnjHwzU0Y3RYS52TA3nfa08y
 LGPLTf5wyAREkFYou20vh5vRvPASoXx6auVf1MuxokDShVhxLpryBnlKCobs4voxN54BUO7m
 zuERXN8kadsxGFzItAyfKYzEiJrpUB1yhm78AecDyiPlMjl99xXk0zs9lcKriaByVUv/NsyJ
 FQj/kmdxox3XHi9K29kopFszm1tFiDwCFr/xumbZcMY17Yi2bQARAQABzSdDb2xpbiBJYW4g
 S2luZyA8Y29saW4uaS5raW5nQGdtYWlsLmNvbT7CwZEEEwEIADsCGwMFCwkIBwMFFQoJCAsF
 FgIDAQACHgECF4AWIQRwYtqk8AG5xmFnAM9owoffxqgCJgUCY8GcawIZAQAKCRBowoffxqgC
 Jtd/EACIWcaxfVt/MH4qqo5ELsjCFPVp+RhVpQDWy8v9Np2YbTcZ4AY2Zj4Pq/HrZ3F/Bh02
 v85C6mNv8BDTKev6Qcq3BYw0iqw6/xLNvRcSFHM81mQI9xtnAWIWfI9k5hpX19QooPIIP3GO
 MdMc1uRUGTxTgTFAAsAswRY3kMzo6k7arQnUs9zbiZ9SmS43qWOIxzGnvneekHHDAcomc/oh
 o7kgj6rKp/f9qRrhForkgVQwdj6iBlW934yRXzeFVF3wr7Lk5GQNIEkJiNQPZs54ojBS/Kx6
 3UTLT1HgOp6UY9RPEi9wubmUR+J6YjLRZMr5PCcA86EYmRoysnnJ8Q/SlBVD8nppGVEcuvrb
 H3MBfhmwOPDc3RyLkEtKfSTB92k1hsmRkx9zkyuUzhcSnqQnpWGJD+xtKHvcHRT7Uxaa+SDw
 UDM36BjkyVcZQy8c+Is2jA55uwNgPpiA7n82pTeT+FRGd+7iCLQHaryu6FO6DNDv09RbPBjI
 iC/q814aeKJaSILP1ld9/PEBrLPdm+6lG6OKOt9DDV6jPmfR96FydjxcmI1cgZVgPomSxv2J
 B1erOggB8rmX4hhWYsVQl1AXZs3LdEpJ6clmCPspn/ufZxHslgR9/WR1EvPMQc8XtssF55p8
 ehRIcVSXDRcMFr3ZuqMTXcL68YbDmv5OGS95O1Gs4c7BTQROkyQoARAAxfoc/nNKhdEefA8I
 jPDPz6KcxbuYnrQaZdI1M4JWioTGSilu5QK+Kc3hOD4CeGcEHdHUpMet4UajPetxXt+Yl663
 oJacGcYG2xpbkSaaHqBls7lKVxOmXtANpyAhS5O/WmB7BUcJysqJfTNAMmRwrwV4tRwHY9e4
 l3qwmDf2SCw+UjtHQ4kJee9P9Uad3dc9Jdeg7gpyvl9yOxk/GfQd1gK+igkYj9Bq76KY8cJI
 +GdfdZj/2rn9aqVj1xADy1QL7uaDO3ZUyMV+3WGun8JXJtbqG2b5rV3gxLhyd05GxYER62cL
 oedBjC4LhtUI4SD15cxO/zwULM4ecxsT4/HEfNbcbOiv9BhkZyKz4QiJTqE1PC/gXp8WRd9b
 rrXUnB8NRAIAegLEXcHXfGvQEfl3YRxs0HpfJBsgaeDAO+dPIodC/fjAT7gq0rHHI8Fffpn7
 E7M622aLCIVaQWnhza1DKYcBXvR2xlMEHkurTq/qcmzrTVB3oieWlNzaaN3mZFlRnjz9juL6
 /K41UNcWTCFgNfMVGi071Umq1e/yKoy29LjE8+jYO0nHqo7IMTuCd+aTzghvIMvOU5neTSnu
 OitcRrDRts8310OnDZKH1MkBRlWywrXX0Mlle/nYFJzpz4a0yqRXyeZZ1qS6c3tC38ltNwqV
 sfceMjJcHLyBcNoS2jkAEQEAAcLBXwQYAQgACQUCTpMkKAIbDAAKCRBowoffxqgCJniWD/43
 aaTHm+wGZyxlV3fKzewiwbXzDpFwlmjlIYzEQGO3VSDIhdYj2XOkoIojErHRuySYTIzLi08Q
 NJF9mej9PunWZTuGwzijCL+JzRoYEo/TbkiiT0Ysolyig/8DZz11RXQWbKB5xFxsgBRp4nbu
 Ci1CSIkpuLRyXaDJNGWiUpsLdHbcrbgtSFh/HiGlaPwIehcQms50c7xjRcfvTn3HO/mjGdeX
 ZIPV2oDrog2df6+lbhMPaL55A0+B+QQLMrMaP6spF+F0NkUEmPz97XfVjS3ly77dWiTUXMHC
 BCoGeQDt2EGxCbdXRHwlO0wCokabI5wv4kIkBxrdiLzXIvKGZjNxEBIu8mag9OwOnaRk50av
 TkO3xoY9Ekvfcmb6KB93wSBwNi0br4XwwIE66W1NMC75ACKNE9m/UqEQlfBRKR70dm/OjW01
 OVjeHqmUGwG58Qu7SaepC8dmZ9rkDL310X50vUdY2nrb6ZN4exfq/0QAIfhL4LD1DWokSUUS
 73/W8U0GYZja8O/XiBTbESJLZ4i8qJiX9vljzlBAs4dZXy6nvcorlCr/pubgGpV3WsoYj26f
 yR7NRA0YEqt7YoqzrCq4fyjKcM/9tqhjEQYxcGAYX+qM4Lo5j5TuQ1Rbc38DsnczZV05Mu7e
 FVPMkxl2UyaayDvhrO9kNXvl1SKCpdzCMQ==
Subject: starfire: set_vlan_mode contains dead code in a while loop
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------5jHuRM0DUaXQTbTuKbqgp4qK"
X-Rspamd-Queue-Id: DF1DB253A12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-266211-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	HAS_ATTACHMENT(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[coliniking@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Action: no action

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------5jHuRM0DUaXQTbTuKbqgp4qK
Content-Type: multipart/mixed; boundary="------------WKjYDhj2PMSoodr1BEMMfNwt";
 protected-headers="v1"
From: "Colin King (gmail)" <colin.i.king@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Jiri Pirko <jpirko@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <299e76bf-6e7e-4332-a4e2-61698cf95c9a@gmail.com>
Subject: starfire: set_vlan_mode contains dead code in a while loop

--------------WKjYDhj2PMSoodr1BEMMfNwt
Content-Type: multipart/mixed; boundary="------------VXDN469OiB9q5WfIAhxwyztF"

--------------VXDN469OiB9q5WfIAhxwyztF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNClRoZXJlIGlzIGFuIGlzc3VlIGluIGZ1bmN0aW9uIHNldF92bGFuX21vZGUgd2l0
aCBjb2RlIHRoYXQgaXMgbmV2ZXIgDQpleGVjdXRlZCBpbiB0aGUgZm9sbG93aW5nIGNvbW1p
dDoNCg0KY29tbWl0IDVkYTk2YmU1M2ExNmE2MjQ4ODMxNjgxMGQwYzdjNWQ1OGNlM2VlNGYN
CkF1dGhvcjogSmlyaSBQaXJrbyA8amlyaUByZXNudWxsaS51cz4NCkRhdGU6ICAgV2VkIEp1
bCAyMCAwNDo1NDozMSAyMDExICswMDAwDQoNCiAgICAgc3RhcmZpcmU6IGRvIHZsYW4gY2xl
YW51cA0KDQoNClRoZSBpc3N1ZSBpcyBhcyBmb2xsb3dzOg0KDQpzdGF0aWMgdTMyIHNldF92
bGFuX21vZGUoc3RydWN0IG5ldGRldl9wcml2YXRlICpucCkNCnsNCiAgICAgICAgIHUzMiBy
ZXQgPSBWbGFuTW9kZTsNCiAgICAgICAgIHUxNiB2aWQ7DQogICAgICAgICB2b2lkIF9faW9t
ZW0gKmZpbHRlcl9hZGRyID0gbnAtPmJhc2UgKyBIYXNoVGFibGUgKyA4Ow0KICAgICAgICAg
aW50IHZsYW5fY291bnQgPSAwOw0KDQogICAgICAgICBmb3JfZWFjaF9zZXRfYml0KHZpZCwg
bnAtPmFjdGl2ZV92bGFucywgVkxBTl9OX1ZJRCkgew0KICAgICAgICAgICAgICAgICBpZiAo
dmxhbl9jb3VudCA9PSAzMikNCiAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCiAg
ICAgICAgICAgICAgICAgd3JpdGV3KHZpZCwgZmlsdGVyX2FkZHIpOw0KICAgICAgICAgICAg
ICAgICBmaWx0ZXJfYWRkciArPSAxNjsNCiAgICAgICAgICAgICAgICAgdmxhbl9jb3VudCsr
Ow0KICAgICAgICAgfQ0KICAgICAgICAgaWYgKHZsYW5fY291bnQgPT0gMzIpIHsNCiAgICAg
ICAgICAgICAgICAgcmV0IHw9IFBlcmZlY3RGaWx0ZXJWbGFuOw0KICAgICAgICAgICAgICAg
ICB3aGlsZSAodmxhbl9jb3VudCA8IDMyKSB7DQogICAgICAgICAgICAgICAgICAgICAgICAg
d3JpdGV3KDAsIGZpbHRlcl9hZGRyKTsNCiAgICAgICAgICAgICAgICAgICAgICAgICBmaWx0
ZXJfYWRkciArPSAxNjsNCiAgICAgICAgICAgICAgICAgICAgICAgICB2bGFuX2NvdW50Kys7
DQogICAgICAgICAgICAgICAgIH0NCiAgICAgICAgIH0NCiAgICAgICAgIHJldHVybiByZXQ7
DQp9DQoNCklmIHZsYW5fY291bnQgaXMgMzIgdGhlbiB0aGUgd2hpbGUgbG9vcCBpcyBjdXJy
ZW50bHkgZGVhZCBjb2RlIHNpbmNlIA0Kdmxhbl9jb3VudCBjYW5ub3QgYmUgbGVzcyB0aGFu
IDMyIChzbyB0aGUgbG9vcCBpcyBuZXZlciBleGVjdXRlZCkuDQoNClRoaXMgbG9naWMgc2Vl
bXMgYnJva2VuLg0KDQpDb2xpbg0K
--------------VXDN469OiB9q5WfIAhxwyztF
Content-Type: application/pgp-keys; name="OpenPGP_0x68C287DFC6A80226.asc"
Content-Disposition: attachment; filename="OpenPGP_0x68C287DFC6A80226.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBE6TJCgBEACo6nMNvy06zNKj5tiwDsXXS+LhT+LwtEsy9EnraKYXAf2xwazc
ICSjX06efanlyhB0figzQO0n/tP7BcfMVNG7n1+DC71mSyRK1ZERcG1523ajvdZO
xbBCTvTitYOy3bjs+LXKqeVMhK3mRvdTjjmVpWnWqJ1LL+Hn12ysDVVfkbtuIm2N
oaSEC8Ae8LSSyCMecd22d9PnLR4UeFgrWEkQsqROq6ZDJT9pBLGe1ZS0pVGhkRyB
P9GP65oPev39SmfAx9R92SYJygCy0pPvBMWKvEZS/7bpetPNx6l2xu9UvwoeEbpz
UvH26PHO3DDAv0ynJugPCoxlGPVf3zcfGQxy3otydNTWkP6Wh3Q85m+AlifgKZud
jZLrO6c+fAw/jFu1UMjNuyhgShtFU7NvEzL3RqzFf9O1qM2muj83IeFQ1FZ65QAi
CdTa3npz1vHc7N4uEQBUxyXgXfCI+A5yDnjHwzU0Y3RYS52TA3nfa08yLGPLTf5w
yAREkFYou20vh5vRvPASoXx6auVf1MuxokDShVhxLpryBnlKCobs4voxN54BUO7m
zuERXN8kadsxGFzItAyfKYzEiJrpUB1yhm78AecDyiPlMjl99xXk0zs9lcKriaBy
VUv/NsyJFQj/kmdxox3XHi9K29kopFszm1tFiDwCFr/xumbZcMY17Yi2bQARAQAB
zSdDb2xpbiBJYW4gS2luZyA8Y29saW4uaS5raW5nQGdtYWlsLmNvbT7CwZEEEwEI
ADsCGwMFCwkIBwMFFQoJCAsFFgIDAQACHgECF4AWIQRwYtqk8AG5xmFnAM9owoff
xqgCJgUCY8GcawIZAQAKCRBowoffxqgCJtd/EACIWcaxfVt/MH4qqo5ELsjCFPVp
+RhVpQDWy8v9Np2YbTcZ4AY2Zj4Pq/HrZ3F/Bh02v85C6mNv8BDTKev6Qcq3BYw0
iqw6/xLNvRcSFHM81mQI9xtnAWIWfI9k5hpX19QooPIIP3GOMdMc1uRUGTxTgTFA
AsAswRY3kMzo6k7arQnUs9zbiZ9SmS43qWOIxzGnvneekHHDAcomc/oho7kgj6rK
p/f9qRrhForkgVQwdj6iBlW934yRXzeFVF3wr7Lk5GQNIEkJiNQPZs54ojBS/Kx6
3UTLT1HgOp6UY9RPEi9wubmUR+J6YjLRZMr5PCcA86EYmRoysnnJ8Q/SlBVD8npp
GVEcuvrbH3MBfhmwOPDc3RyLkEtKfSTB92k1hsmRkx9zkyuUzhcSnqQnpWGJD+xt
KHvcHRT7Uxaa+SDwUDM36BjkyVcZQy8c+Is2jA55uwNgPpiA7n82pTeT+FRGd+7i
CLQHaryu6FO6DNDv09RbPBjIiC/q814aeKJaSILP1ld9/PEBrLPdm+6lG6OKOt9D
DV6jPmfR96FydjxcmI1cgZVgPomSxv2JB1erOggB8rmX4hhWYsVQl1AXZs3LdEpJ
6clmCPspn/ufZxHslgR9/WR1EvPMQc8XtssF55p8ehRIcVSXDRcMFr3ZuqMTXcL6
8YbDmv5OGS95O1Gs4c0iQ29saW4gS2luZyA8Y29saW4ua2luZ0B1YnVudHUuY29t
PsLBdwQTAQgAIQUCTwq47wIbAwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgAAKCRBo
woffxqgCJo1bD/4gPIQ0Muy5TGHqTQ/bSiQ9oWjS5rAQvsrsVwcm2Ka7Uo8LzG8e
grZrYieJxn3Qc22b98TiT6/5+sMa3XxhxBZ9FvALve175NPOz+2pQsAV88tR5NWk
5YSzhrpzi7+klkWEVAB71hKFZcT0qNlDSeg9NXfbXOyCVNPDJQJfrtOPEuutuRuU
hrXziaRchqmlhmszKZGHWybmPWnDQEAJdRs2Twwsi68WgScqapqd1vq2+5vWqzUT
JcoHrxVOnlBq0e0IlbrpkxnmxhfQ+tx/Sw9BP9RITgOEFh6tf7uwly6/aqNWMgFL
WACArNMMkWyOsFj8ouSMjk4lglT96ksVeCUfKqvCYRhMMUuXxAe+q/lxsXC+6qok
Jlcd25I5U+hZ52pz3A+0bDDgIDXKXn7VbKooJxTwN1x2g3nsOLffXn/sCsIoslO4
6nbr0rfGpi1YqeXcTdU2Cqlj2riBy9xNgCiCrqrGfX7VCdzVwpQHyNxBzzGG6JOm
9OJ2UlpgbbSh6/GJFReW+I62mzC5VaAoPgxmH38g0mA8MvRT7yVpLep331F3Inmq
4nkpRxLd39dgj6ejjkfMhWVpSEmCnQ/Tw81z/ZCWExFp6+3Q933hGSvifTecKQlO
x736wORwjjCYH/A3H7HK4/R9kKfL2xKzD+42ejmGqQjleTGUulue8JRtpM1AQ29s
aW4gSWFuIEtpbmcgKEludGVsIENvbGluIElhbiBLaW5nIGtleSkgPGNvbGluLmtp
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
=3DQKm6
-----END PGP PUBLIC KEY BLOCK-----

--------------VXDN469OiB9q5WfIAhxwyztF--

--------------WKjYDhj2PMSoodr1BEMMfNwt--

--------------5jHuRM0DUaXQTbTuKbqgp4qK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEcGLapPABucZhZwDPaMKH38aoAiYFAmmwMvsFAwAAAAAACgkQaMKH38aoAib/
SRAAg8dns/QDy1QrExTNvKWAytCTCmceEUJ3p/Wxp3iAE67fBtVUpjG2bcaJ+5cb91z6AfPoMtzL
C+dxhRjLKB1AnJtnyog1I9eFPS2//tyONretw9AEK1knMZdTAedJjKHNBaBsLGGiyu5sKQbmSpHv
narCqgXyBTuwFZo/+Gdn/ojbxuoEGG3627Ua+EJM4aZd12Z6hv8hhi09Aq+OD9Nc2bp5Mz4GeA6R
VpUeUH40FJZr+GP1OD51nJwXLZZKW7EXLA0LKEVyq8I+ERF5iWB43vb+YsFNcnaRHiKSoVsKccuS
dMpF3U85SRp8k1vNBmpyQz5CKfyI4kChcIZJGE+w0EQkhXMWp7N7EQfL6GZyVH3GjiAJiu2pmMH9
Q/vdvrtR98i+A/uOBxphhNi/5JuONifKfEt9G26gNIulEOC3pxho+uQ6Gma8RwEe1UXObafgAumv
zziGsNZlaIDVvC39NwQsWhXGgLyEmyNIuhnHpgmPnL8atn5YdiuruxNTVaQQDDbB0vS+rbdxdIFb
CofrTz12LEhIALY++yl7wl5J/m6GUXaDd5yJ/ehM24RKd6vTGvG1lgPajoXkcrwFgy4h3d/xDF+g
atu8ah9ikMjlL5oNno0qsyZ6Id3Luw8PleYxkPWMuefoVsT834jvs/HvkXuzd3zPVz5lPrtDIoZu
sps=
=Ah7H
-----END PGP SIGNATURE-----

--------------5jHuRM0DUaXQTbTuKbqgp4qK--

