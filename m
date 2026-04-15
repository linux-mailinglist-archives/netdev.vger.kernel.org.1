Return-Path: <netdev+bounces-278606-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOhhDGnb3ml1JQAAu9opvQ
	(envelope-from <netdev+bounces-278606-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 02:27:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FB53FF4BA
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 02:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02F65302F27E
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 00:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7951A245008;
	Wed, 15 Apr 2026 00:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.com header.i=benoit.dufour@mail.com header.b="adKGoD16"
X-Original-To: netdev@vger.kernel.org
Received: from mout.mail.com (mout.mail.com [74.208.4.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA4E238166
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 00:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776212838; cv=none; b=MRMzMYorlZpqOajKYcg93aHgJ6dHk4ibdStdNHPT2vrVNZjO2+lD9d7x5PQLvvuknXcKPPP2qFtuwr7o1Wt4sOVcf3U8kjcQBxTCIt58CfCIgjcpc6AxlDoAJgN250Lzc2Yr/6PcGecUAyJ8qvRMZtzKzq6UNxxJ3AXq/xGxUSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776212838; c=relaxed/simple;
	bh=IfnKBzATh3hmfeY/H4u5MbTbPQrZ0F7R2HtJP1J+8lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ainqmxda79eHgNlk5S0Nr6PdB48UIEAfw/77zLBichVNAw4w1rsyXWra4HkgFrSQjixF5enMQtc7PNv+2pTB7WaTQKwKbO+l7ZheAO0AncqiQ11yMOrs3aP1Joj6/ilwpC3KBf8abXd9RronzB5n9xhNA89pps6Z46cJNrGEVkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.com; spf=pass smtp.mailfrom=mail.com; dkim=pass (2048-bit key) header.d=mail.com header.i=benoit.dufour@mail.com header.b=adKGoD16; arc=none smtp.client-ip=74.208.4.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.com;
	s=s1089575; t=1776212833; x=1776817633; i=benoit.dufour@mail.com;
	bh=YaUzVhFhcPH3MG2RPG3LsIrc8377v/EjWA9Y6XoPa6g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=adKGoD16L8BtQ0+W195hOFFgNVGdBhq4JdWhG4BW21CeIt0PFdjqGfMaPuWZFYc+
	 YThCtO0u+qhwAcFc7r+Lxmuh6nh8ET1JUiyY3hcsC5tLWATmqw0Kw9VwQ52M+uNmZ
	 DO+jzy2SYg9M7IKskt/xUKnoIb/Cx9ajUaQY2s3dnTjokfKSuMP5FgnYNab36OpF7
	 N7RapNvX9xk05jZlRBHVpuPnY/2tv7AeFHogzPwJFQMvoU1QZ1HFzCa/Yc1jV75E5
	 WTz3oqV3crS33BAzOshCGJw298u9G2Ru07wZ8yzSxnP4Z2r7TaU75RrKJrNCZD/3w
	 JnD+mYdLy8vEDbCs2g==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from client.hidden.invalid by smtp.mail.com (mrgmxus005
 [74.208.5.15]) with ESMTPSA (Nemesis) id 0Lbtg2-1vlD6b2uO4-00o9PC; Wed, 15
 Apr 2026 02:27:13 +0200
Message-ID: <029aa619-b489-47b8-a0ef-2d3b221cddd1@mail.com>
Date: Tue, 14 Apr 2026 20:27:10 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: DMA issues with the SKGE drivers
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
References: <9df653d6-d7f8-4b36-87de-65daf28635dd@mail.com>
 <c3130329-a7ea-406c-9ac1-2fa5d9d3a8bc@lunn.ch>
Cc: netdev@vger.kernel.org
From: =?UTF-8?Q?Beno=C3=AEt_Dufour?= <benoit.dufour@mail.com>
Autocrypt: addr=benoit.dufour@mail.com; keydata=
 xsFNBGmlBagBEADC+mB+ljUVdIPDgU+cNqVliKXYGkqiXmQ2xGO5RtCakbUidnPGTxbnC5Zk
 vgZMzwdRj7j2sFyf5H9Bpk64566QIiH1wK39l47gtPI8ykgOkfWQbWVhSg4H60taN99Q3UAx
 StUEVBIvXCJykouIPKkvl9ngmgqEwkY+yYmRV1l55QN4bcH9E/3x9YPANF8CMy8nXE8pkkoh
 JKRC4nMyKuijzgxUPLlwp9DoMdJodS4dC2Fwzwi9ey/WU6+k35xxk1jcQvOQul+Z4wXWEqkv
 krNw1rTLxi6o8T5GsxGFDB5gcWUZ/wyM2om4IVHvmxQRVXlfMG8za+q9HaG8FwwZ6DEd90CA
 8JUX3ssc+pZiWqQZyoa4MoouxTf9Krj4G1RIf5dzNGlp8R1ubE33Pdu7ahmpErf/mhiVCFLX
 hxrNwQ3aTK6k2ecMpJ+RlbbppnlgPxNiMfbkwcI6QI1PdYCzZ6wdI+PCEz4DNPFp4Ve1A2aR
 8aZ9Pg7+N1RrhYnWlvUHTRcCy4aCsg+aJ8/y/GRlXOsHbyp1+4sJURvJhET8R2AqoYCcYuNa
 kS4wPj67lOTmkRgnHjscH3rsoWpHARZNIdECqHN0Uw669eWHirUdqdmvd7oclgcqdVlHiATi
 ijhE3BX+2UpsRNez0vhfWGCQFByNkEb0D1Dq5b3o4XfwGEoDNwARAQABzUhCZW5vw650IER1
 Zm91ciAoYmVub2l0LmR1Zm91ckBtYWlsLmNvbSAtIEVNQUlMKSA8YmVub2l0LmR1Zm91ckBt
 YWlsLmNvbT7Cwa0EEwEIAFcWIQRhNxuBW225fNbJOW2m5JTP9taF7wUCaaUFqBsUgAAAAAAE
 AA5tYW51MiwyLjUrMS4xMSwyLDICGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 puSUz/bWhe9Ewg/8CXuOHT/uYZwMBKR2GQHInuK+kQZ0qHEc+tMnNAM3x8w1B6+htQfnpCb1
 1O4KMyHrPAujT2hPaGScqXZqsG2/1xpyk0u56bEes1XR08M8JIrl+S2kx+rkcGSIG3UrPEW7
 vXa7bWczaGXLxf92djtdXeT38hNCFxP6v49IqEhwQePf5nFNhDO2IxsJcsB51MX8vWCnW53M
 ShAGOOV7YwFUN0BdpfnTFVy1XaLddbzuq0h3Eww243QLMCKMY3ZB4NdNm5ZcH88bf42RHsvD
 pX/uSn/Y4H6rQ64I3PaoiTlUJYHhxIAXMCAB8tUW8xTjLqN2IjuH5Ab/UDVHEh1TTcbVOtrn
 lv4xlUqcpzHcT9ZEA1nATsRa87nAuOKMdAoE4eC6Il/8iIDrd0QTYtvAQbF4AGetMK+yyJLh
 68ErIFBWKlhX0K/SjVzFnE6cTaGlMFm9uImX4RYMLcYDegc/KoTPq6w3/I6bdRx+9J7vMFtf
 whL8jj7SXDZzpKon00xlsT5muXWqmb05P06XBZ+gKG0EiPSOwX9zE9lQ4lIL3fZjmBQ8YOqw
 u8KFfJt8l6Ronz6dPr319IAAFZFAptNePPKc538C8HgmvJCbe0FiBuJSAXQvtjp2ykmQqc3P
 Re0swVC7kzu7IEdh63e2tZbxy71wIGRQI3rwhV/8YYZhzbSfbtrOwU0EaaUFqAEQALRPVBuM
 e+jQyEn/erc2s01VwLK6JrqVs2lt+18n5saATOiEmjHZPCM49qQNLWYnmCRt1M0ML15Npnii
 OIdulr+MEB0L4BKXsrPkCcQpwccCLU0n39kFdNKw+OI4elgkZ8qW3DVyIMXAMahysQUN3XwW
 q2mzM7LgSIJQGxeFILvMBXSA9AZQqY7dWBEEpl7DcP/PMels2PLUhzxKgA1BRlnHHeqSF1Re
 8NFEp4UAkX++nUl6cfdgl/rLgyDv9BekOBkkEWTPm0XrN69IhTDPDOLNxM0etKCoI5gEMBSi
 xg5sHsQlJn0yudKlUUE6qbI6BGe+PyOZcZsRRiWI8OoW/Mo0CiQlkzCNxYcpDxntfni2JiOP
 P8aVH6Rz1VrdNslrqLDG7uFCW5GaXygQp962RfG4rLPooqPcIDg7qfLfwGshFGMAs3HppudE
 MVJlxcvcJ9JZW6BhTreH4m5CquAZvtjU+HBLECE26hSZblmg4y2V4nIEuqMcvQAFTrYZL9RG
 ABodPzJRlKCZmoxN36ZtO1Btox7SlPArfMl7WwarU+ZZzBD9C21seSEYnxAYzDNaClzknGyo
 JyL1yBWYN1yyH454bwF0JY8pg+iwR687iLc9hGHpq2wTUnBZTKl73RqQlFXI0kCgapL6gauv
 CDwQRgG1v5b9YToN9YnLHeUc2Cs9ABEBAAHCwZIEGAEIADwWIQRhNxuBW225fNbJOW2m5JTP
 9taF7wUCaaUFqBsUgAAAAAAEAA5tYW51MiwyLjUrMS4xMSwyLDICGwwACgkQpuSUz/bWhe/o
 UxAAssz1tod2gTB7NjqlMkuUsKvWQqDxitRDEeSc764HFkAVnufMZ/BSfjQOFMjCCJ07Sqyp
 qyX9Qf8Y4tcUCj/FebVoSKS9KoUIW2nmI+bHxlOXWBRVGc/7tSKT+Dmq09IW7911J/xwYZmO
 vbwI0J3L+Z+0qzTuZv1fblEk1BH5Z9l7H7ukeWgXpTf8RsJY02p9jjtoKewDqg3QXhDbh5DA
 DtS5eX/YzOfGxkB2pCJvpyK91+Bkq0GU18njIV8rUpa0+3Sk4P+pYCCD3qeCk9oEcYiDyASU
 eeDDLQaoxktCbEdyFPMNjF8t3QObTsWMf4jVNDAvwLysOjXe2RCwhyijFrrE1DGUh64+iklD
 rZ2L7kst/Jt1E/xD6v4dd41odsT+p95K3mDObVuRnAFKw1SyBRQFSWW3YukLH5lrBhoL+rjm
 N4bMOwRD1Q/m5FFbT0OYtXalDtPmSrtSWOWeVrD6RcWRT8nwZT8POXk2par0Wezhe+BtnJ7F
 RThMvDYOYDTKKf805jSAM6B8c851w9TeU3UWbhb19PuFpz/wZ2L6Gk/hLCHLoVaxASOGE/e2
 /0AzlnBldo0Q4dX/eq71lWvnh2T4Sj1yNOcLBd5oDqnk+VM3SoYabPTosqNPYTyGt4QNdfln
 9+VMTFFmtZldddzyju2amRgGS9sW0eEMfseKnXs=
In-Reply-To: <c3130329-a7ea-406c-9ac1-2fa5d9d3a8bc@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t+1vzDV36TBTxV9NjlTEdTQ/1kHWXCvIINiktFRgLCnlAGMX6lY
 son+AsvIqEKrf8s4MaFc5QT5R85gRCrvT5MM2mA6AVxpoWoZNQDGRVX7HnnYQaW8B2gYwL/
 21X0+oZBa/dfJ74hX3pMy7zq5RNlyNnjYQQ8fb7S0oUIPcbFu/9iir+4TxDFXJr7a1ZIeDs
 MnMqmaqEAdhthREQgj9SA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MpMX5fz/aCI=;gqp4/3SnGPHTYoNGJ45TpEFoS2A
 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
 lv
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mail.com:s=s1089575];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278606-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benoit.dufour@mail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[mail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 76FB53FF4BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Yes, I guess I'd be able to, but only after testing it.
I'm currently waiting a new cooler that would support the 110 W TDP of=20
my Opteron 180 X2.
The previous cooler I tested were definitely not good enough for cooling=
=20
that CPU.
Just running MemTest86+ for too long made the CPU overheat.
Even the Arctic Cooler Freezer 7 CO wasn't good enough.

Le 14/04/2026 =C3=A0 20:12, Andrew Lunn a =C3=A9crit=C2=A0:
> On Tue, Apr 14, 2026 at 07:23:17PM -0400, Beno=C3=AEt Dufour wrote:
>> In 2024, I reported a bug about the SKGE driver, you can see it here:
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D219270
>>
>> Basically, the problem is that the Marvell 88E8001 on my ASUS A8V mothe=
rboard
>> can only work with 32bit DMA, and if trying to use 64bit DMA, the NIC w=
on't
>> work at all and after some time, the operating system will become compl=
etely
>> unresponsive (on screen tty will stop refresh, keyboard and mouse input=
 will
>> stop working too).
>>
>> The fix is quite easy:
>>
>> At the very end of the SKGE driver source code, the ASUS A8V motherboar=
d (as
>> well as many other boards like the ASUS A8V Deluxe) should be added to =
the list
>> of 32bit DMA boards:
>> https://github.com/torvalds/linux/blob/508fed6795411f5ab277fd1edc0d7adc=
a4946f23
>> /drivers/net/ethernet/marvell/skge.c#L4150
> Hi Beno=C3=AEt
>
> Could you submit a patch adding the needed entry for your board?
>
> 	Andrew
>
>
=2D-=20
Beno=C3=AEt Dufour

Unfortunately still a student in Computer Science


