Return-Path: <netdev+bounces-196584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDD8AD5802
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 16:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725AB189325F
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 14:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5282690FB;
	Wed, 11 Jun 2025 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="GQ2cf/1R"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CCF155322
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749650834; cv=none; b=s6O/EdhMXDgxKaBw9uqoz85Ed4Zp4HxSMix1CBgEycjdU+9lqQjZXwWCsdA8ZvCX6KEe9tys7lzZxYunogXZ6drwaIvoHsTQB7wPpvpTNjvsmpZJEIeVrGE1Capj3Fimabor6uzvxot6nhXW7Q9uhNrRoNrc+CNNp9V26wXcA7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749650834; c=relaxed/simple;
	bh=l1eK4WfobiPcQHoZlxq7PNzudSMtwa6rDk9UaKLDpaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=exa6Te5liFGcgNJOoAcJlzYpsYunINAl8KKgdXyOHohfFV5FSZmuZeVhxpKiuLknRj/xvOjcOaRE4gtWiw48C7sVrcDOb9/zdCk6zq1qGXlDEf3wLEUj/KKpOpJipyQITwj70ETKrlMxYZl0bbKnjAvKCZG4HtkJxF8844LvsKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=GQ2cf/1R; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=BBeWvHLJIY1+bTKes60lC3NxANx4xNqYyog9sHYbuMI=; b=GQ2cf/1Rk3ydSqZtdaUCf+KuYk
	ITtRc44qVMlD/0RwMLR9o8YUPS6wGy29scf2bNkaz+ViR4HBSaKv6t31ELkK4I60Xj+UHZobT104o
	ygjqASdwyFmggMwSLbSMqLljgYdSbKNhpk/DChQuUNpepxNnAnQN3Im0qBq5wbVB8+I/hNhOHV97x
	R3FtwjIWIeDn79i4TEPC/bWMSIU0fP3RQ4ZEjhafU0Mju7D3h5aAu7smb2gM89AOAFPsm2wm9Zr1l
	yxdDDE9onu1EUxx/AddJ8rtupRCjvutd24XsWYlkezqHU6jEMp/A7Wi5l4OECfABvgBpXV6ZHxGYX
	Gn4jNO0A==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uPM6Y-000BTt-0d;
	Wed, 11 Jun 2025 16:07:02 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1uPM6X-000Fph-2p;
	Wed, 11 Jun 2025 16:07:01 +0200
Message-ID: <1cfae3f3-d1cf-413e-8659-a6bd72b03a71@iogearbox.net>
Date: Wed, 11 Jun 2025 16:07:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG iproute2] Netkit unusable in batch mode
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>,
 Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 Nikolay Aleksandrov <razor@blackwall.org>
References: <4c0389de-1e74-46f8-9ce8-4927241fd35c@orange.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 xsFNBGNAkI0BEADiPFmKwpD3+vG5nsOznvJgrxUPJhFE46hARXWYbCxLxpbf2nehmtgnYpAN
 2HY+OJmdspBntWzGX8lnXF6eFUYLOoQpugoJHbehn9c0Dcictj8tc28MGMzxh4aK02H99KA8
 VaRBIDhmR7NJxLWAg9PgneTFzl2lRnycv8vSzj35L+W6XT7wDKoV4KtMr3Szu3g68OBbp1TV
 HbJH8qe2rl2QKOkysTFRXgpu/haWGs1BPpzKH/ua59+lVQt3ZupePpmzBEkevJK3iwR95TYF
 06Ltpw9ArW/g3KF0kFUQkGXYXe/icyzHrH1Yxqar/hsJhYImqoGRSKs1VLA5WkRI6KebfpJ+
 RK7Jxrt02AxZkivjAdIifFvarPPu0ydxxDAmgCq5mYJ5I/+BY0DdCAaZezKQvKw+RUEvXmbL
 94IfAwTFA1RAAuZw3Rz5SNVz7p4FzD54G4pWr3mUv7l6dV7W5DnnuohG1x6qCp+/3O619R26
 1a7Zh2HlrcNZfUmUUcpaRPP7sPkBBLhJfqjUzc2oHRNpK/1mQ/+mD9CjVFNz9OAGD0xFzNUo
 yOFu/N8EQfYD9lwntxM0dl+QPjYsH81H6zw6ofq+jVKcEMI/JAgFMU0EnxrtQKH7WXxhO4hx
 3DFM7Ui90hbExlFrXELyl/ahlll8gfrXY2cevtQsoJDvQLbv7QARAQABzSZEYW5pZWwgQm9y
 a21hbm4gPGRhbmllbEBpb2dlYXJib3gubmV0PsLBkQQTAQoAOxYhBCrUdtCTcZyapV2h+93z
 cY/jfzlXBQJjQJCNAhsDBQkHhM4ACAsJCAcNDAsKBRUKCQgLAh4BAheAAAoJEN3zcY/jfzlX
 dkUQAIFayRgjML1jnwKs7kvfbRxf11VI57EAG8a0IvxDlNKDcz74mH66HMyhMhPqCPBqphB5
 ZUjN4N5I7iMYB/oWUeohbuudH4+v6ebzzmgx/EO+jWksP3gBPmBeeaPv7xOvN/pPDSe/0Ywp
 dHpl3Np2dS6uVOMnyIsvmUGyclqWpJgPoVaXrVGgyuer5RpE/a3HJWlCBvFUnk19pwDMMZ8t
 0fk9O47HmGh9Ts3O8pGibfdREcPYeGGqRKRbaXvcRO1g5n5x8cmTm0sQYr2xhB01RJqWrgcj
 ve1TxcBG/eVMmBJefgCCkSs1suriihfjjLmJDCp9XI/FpXGiVoDS54TTQiKQinqtzP0jv+TH
 1Ku+6x7EjLoLH24ISGyHRmtXJrR/1Ou22t0qhCbtcT1gKmDbTj5TcqbnNMGWhRRTxgOCYvG0
 0P2U6+wNj3HFZ7DePRNQ08bM38t8MUpQw4Z2SkM+jdqrPC4f/5S8JzodCu4x80YHfcYSt+Jj
 ipu1Ve5/ftGlrSECvy80ZTKinwxj6lC3tei1bkI8RgWZClRnr06pirlvimJ4R0IghnvifGQb
 M1HwVbht8oyUEkOtUR0i0DMjk3M2NoZ0A3tTWAlAH8Y3y2H8yzRrKOsIuiyKye9pWZQbCDu4
 ZDKELR2+8LUh+ja1RVLMvtFxfh07w9Ha46LmRhpCzsFNBGNAkI0BEADJh65bNBGNPLM7cFVS
 nYG8tqT+hIxtR4Z8HQEGseAbqNDjCpKA8wsxQIp0dpaLyvrx4TAb/vWIlLCxNu8Wv4W1JOST
 wI+PIUCbO/UFxRy3hTNlb3zzmeKpd0detH49bP/Ag6F7iHTwQQRwEOECKKaOH52tiJeNvvyJ
 pPKSKRhmUuFKMhyRVK57ryUDgowlG/SPgxK9/Jto1SHS1VfQYKhzMn4pWFu0ILEQ5x8a0RoX
 k9p9XkwmXRYcENhC1P3nW4q1xHHlCkiqvrjmWSbSVFYRHHkbeUbh6GYuCuhqLe6SEJtqJW2l
 EVhf5AOp7eguba23h82M8PC4cYFl5moLAaNcPHsdBaQZznZ6NndTtmUENPiQc2EHjHrrZI5l
 kRx9hvDcV3Xnk7ie0eAZDmDEbMLvI13AvjqoabONZxra5YcPqxV2Biv0OYp+OiqavBwmk48Z
 P63kTxLddd7qSWbAArBoOd0wxZGZ6mV8Ci/ob8tV4rLSR/UOUi+9QnkxnJor14OfYkJKxot5
 hWdJ3MYXjmcHjImBWplOyRiB81JbVf567MQlanforHd1r0ITzMHYONmRghrQvzlaMQrs0V0H
 5/sIufaiDh7rLeZSimeVyoFvwvQPx5sXhjViaHa+zHZExP9jhS/WWfFE881fNK9qqV8pi+li
 2uov8g5yD6hh+EPH6wARAQABwsF8BBgBCgAmFiEEKtR20JNxnJqlXaH73fNxj+N/OVcFAmNA
 kI0CGwwFCQeEzgAACgkQ3fNxj+N/OVfFMhAA2zXBUzMLWgTm6iHKAPfz3xEmjtwCF2Qv/TT3
 KqNUfU3/0VN2HjMABNZR+q3apm+jq76y0iWroTun8Lxo7g89/VDPLSCT0Nb7+VSuVR/nXfk8
 R+OoXQgXFRimYMqtP+LmyYM5V0VsuSsJTSnLbJTyCJVu8lvk3T9B0BywVmSFddumv3/pLZGn
 17EoKEWg4lraXjPXnV/zaaLdV5c3Olmnj8vh+14HnU5Cnw/dLS8/e8DHozkhcEftOf+puCIl
 Awo8txxtLq3H7KtA0c9kbSDpS+z/oT2S+WtRfucI+WN9XhvKmHkDV6+zNSH1FrZbP9FbLtoE
 T8qBdyk//d0GrGnOrPA3Yyka8epd/bXA0js9EuNknyNsHwaFrW4jpGAaIl62iYgb0jCtmoK/
 rCsv2dqS6Hi8w0s23IGjz51cdhdHzkFwuc8/WxI1ewacNNtfGnorXMh6N0g7E/r21pPeMDFs
 rUD9YI1Je/WifL/HbIubHCCdK8/N7rblgUrZJMG3W+7vAvZsOh/6VTZeP4wCe7Gs/cJhE2gI
 DmGcR+7rQvbFQC4zQxEjo8fNaTwjpzLM9NIp4vG9SDIqAm20MXzLBAeVkofixCsosUWUODxP
 owLbpg7pFRJGL9YyEHpS7MGPb3jSLzucMAFXgoI8rVqoq6si2sxr2l0VsNH5o3NgoAgJNIg=
In-Reply-To: <4c0389de-1e74-46f8-9ce8-4927241fd35c@orange.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.0.7/27665/Wed Jun 11 12:10:36 2025)

Hi Alexandre,

On 6/11/25 2:08 PM, Alexandre Ferrieux wrote:
[...]
> Playing around with netkit to circumvent veth performance issues, I stumbled
> upon a strange thing in iplink_netkit.c : the presence of three static variables
> which tend to wreak havoc in case of multiple netlink commands in batch mode (ip
> -b) : "seen_mode", "seen_peer", and "data".

Hah, never used batch mode :/

> As a consequence, the following simple batch sequence systematically fails:
> 
>      # ip -b - <<EOF
>      link add a1 type netkit peer a2
>      link add b1 type netkit peer b2
>      EOF
>      *    Error: duplicate "peer": "b2" is the second value.*
> 
> While the patch below solves the problem, I wonder: why in the first place are
> these three locals declared static ? Is there a scenario where
> netkit_parse_opt() is called several times in a single command, but in a
> stateful manner ?
> 
> Thanks for any clarification
> 
> -Alex
> 
> diff --git a/ip/iplink_netkit.c b/ip/iplink_netkit.c
> index 818da119..de1681b9 100644
> --- a/ip/iplink_netkit.c
> +++ b/ip/iplink_netkit.c
> @@ -48,8 +48,8 @@ static int netkit_parse_opt(struct link_util *lu, int argc,
> char **argv,
>   {
>          __u32 ifi_flags, ifi_change, ifi_index;
>          struct ifinfomsg *ifm, *peer_ifm;
> -       static bool seen_mode, seen_peer;
> -       static struct rtattr *data;
> +       bool seen_mode=false, seen_peer=false;
> +       struct rtattr *data=NULL;
>          int err;
> 
>          ifm = NLMSG_DATA(n);

This was basically because we call into iplink_parse() after "peer" to gather settings
for the peer similar to link_veth.c modulo that netkit has mode/policy/scrub settings
and we only want them to be present once for a single 'link add' call. Might be better
to just reset the above before the 'goto out_ok' after parsing peer. Could you cook a
patch for that instead?

Thanks,
Daniel

