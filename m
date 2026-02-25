Return-Path: <netdev+bounces-261027-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKjuD14mn2mPZAQAu9opvQ
	(envelope-from <netdev+bounces-261027-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 17:42:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0619519AD3A
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 17:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 999E530087F7
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65231917FB;
	Wed, 25 Feb 2026 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nG+HvkFo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810F83D7D7F
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772037346; cv=none; b=lJg9dBBp46SQeaYfMI3rCBWlIZ0iBspqXuUomUPzCRGA3u7JtW25y9749cC5euTpL6Cn2Ox/+XGi9JjF98FIi1WrtMboT2Upht+lCWQDdAwcMeeK5oRT9qcxYmJnTwimd/PvghFUNUzXyeLrCKCHF4hq1nJgoRmxSNGoGdIYuO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772037346; c=relaxed/simple;
	bh=N2UMPrkIe31j4aJuqbuRgVryoskRYO0Far8UeIfsCB4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ogYXcGEkJQthf+PGdwDf+/k6yvn1voQX1X3fRGtnBGGheSpWFu5gSmAHgQX+tf0b3ffiB29jA0LT5rE2k5mwbwuvx1HOkbdnrUgO/kplGeO7L/KWdFxFYRlXVu0GgLgMySi75HnsXJwiOy9qB9DsvqNLF1ByN/akfF2PR1SLA3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nG+HvkFo; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-358f5aeb46eso766697a91.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 08:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772037345; x=1772642145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FF5rB0m7X9JopCsNwyZqrTsOQj25863I1pJhudGCwMI=;
        b=nG+HvkFozWDEtePs5/my1C/sRFbrZOepiOIcVM1nr2XO9qJZDf1iFBqka6n7C6K1fA
         XUlFTfBk9MBIvOj40lCkJBaSlJq2VqKcu9aLTmdJp6536WwMI1ZvNxlJQfAmj6RdKDGl
         nVGmwkjkLi7Nzsu5mphwJIKEujH0fAADE8M9k5EHHWC1hgJG9pUKvMjPjIeEK3AkRhZg
         hWAfbxUoe0J5Z+0U7xkveW2fIf7HYcdiWEXTAbpcX6yNHYof4OjEdHE+7m9QzPecxZuw
         U8tGDy3N8geSa8V0Ck73zgQXyNxtFcnPhAnZr6ZiLWtTzXJRuIjnJD4K5ytkaZaGQ+RN
         NqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772037345; x=1772642145;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FF5rB0m7X9JopCsNwyZqrTsOQj25863I1pJhudGCwMI=;
        b=ZVcb3N/sOVkbQZ3rda0Ow/MI4SU4zuHNxYLJkOZVjrcEfLlq4Dpd7g09cnlykZLCW1
         H6q53Y6EuDGWtT92hUcTTr9PgebOugkr647ty5cWM7zmYBQRB5rBD+8qwOP8pOwJ4d+v
         Wunv6tbCifr1tTzBmFeyUKnRkaK/pr+fPzToPxS9OdaLUGgJT9D0aaOi8ND9DdfKjhP8
         GcHGgmqoC1Txsgr7I/nLvM5JU++2x75AKDj2ogVt0/+sWorYTIQuUJqVLA/wOjBY9CfE
         p8vVeItWI/rlqfQ4HehrwdB3ofZoc9YVQzf8YvJvwtzu1XwzCFc0wpZeT/K1Pm3j10b7
         rvcg==
X-Forwarded-Encrypted: i=1; AJvYcCWl0AlEh6G/i+Roq+98jYMY7A+vwG23tpsBT6nQFvEPUM9bn5pZMduy3N0m1PtdThszYrbVcKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwybuAj0beTBulIIMO7mmFkZDVoJBS6gulvvsqJCtaTH0d2a1wq
	RjkHApvX2wIOlLgy94SqvpT2nBNlspxba/xidNnvYSADX5IXJESoo+Xi
X-Gm-Gg: ATEYQzwxVvj+f2iV5+UwZpemoWDzTi0peaCisS7U1LlAvyjVtS72SZq7gM2NrSaaHhu
	6FWb2t+MYLLLlo//yGSei4svbFIlO/lsVc4y2gYjZJ/hzGpuwhtpugINY7OU+rtv5C0FGNwtlyG
	k/xbXOMqz6ScxzcikOjaVLOURh64xcGW9q8J3zaJCn16ulu9MRBRIFlRd3yQR5cbaiLXYXBahrk
	OFxnaJSgk6I7fWTnjF48sECx7ScVTdAK3Niu8f0Gh6m9cbe1SswxKfMnqSD/+Qzv6L262PcXhU0
	o4wfwU19zZqm4j1J8CiAwf4yNGFd6TjAFqcpIOD/yZUpY4e0SXAxe3WNS4k2N5BWPLS05jKclRq
	AmT+s0RQRhy6x0Vkk1rwfM6HIcp9aW2W4s5VOWz0WYdkljYMqkLMBgv7xlnIfTfeWXinNhh6PcW
	rms15HbtRVkOKmP+BHyS+/W0sghDvp3VgLlLuiXN4TPDNIGV2P/WLktPDiYuX3PeJ8ZW4S
X-Received: by 2002:a17:90b:1fcf:b0:358:d80e:383a with SMTP id 98e67ed59e1d1-35928a59dbfmr733451a91.2.1772037344875;
        Wed, 25 Feb 2026 08:35:44 -0800 (PST)
Received: from ?IPV6:2405:201:2c:5868:dd50:6a2e:d27f:77bf? ([2405:201:2c:5868:dd50:6a2e:d27f:77bf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35912f4afddsm937092a91.2.2026.02.25.08.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 08:35:44 -0800 (PST)
Message-ID: <b7df8a5b-95ad-4cd6-860c-1adb1f89a7f6@gmail.com>
Date: Wed, 25 Feb 2026 22:05:39 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/sched: Fix divide error in tabledist
From: Manas Ghandat <ghandatmanas@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: stephen@networkplumber.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251222061306.28902-1-ghandatmanas@gmail.com>
 <aVA4YJIT6at11JwH@pop-os.localdomain>
 <e68da695-2fdd-4692-999b-566c1b521f47@gmail.com>
Content-Language: en-US
Autocrypt: addr=ghandatmanas@gmail.com; keydata=
 xsFNBGlvWocBEAC6MISM6mdR6cfNF+oXbAxUfksT8nnbNmElzBuYpn5xdQLAdw/cHGeNv6aM
 H5rWl0VzAqYWQO6p14BnRsgXLW3QMmOW30naoqXmXVMCKp2wWlTL9injLsETOizlzSwQ4lRl
 OBGniSkWankLuxFgUBdax8lnXrNhrdi5RoQfo2tm37NltSpU8oXhljGBYlLut2N/XC34oB+S
 d9Ai7pZ/0E+GE48TJ4I85qyOZpxjx2LN/imWJc7fJ+fkY50guQn0mKkVljSxsGH0sGYch/55
 jurKuYsXt9ttLF6CKf2SFy+hk3faJ+Cb+4LjxNyZCc+KzPjq9lS/bl4Ct5U0fJK3yWOwau7i
 uWhEDNhGHb2OR+w++l8fFuUitIVKJapxtJElYPlhpciWl1iFtxrf9pYbNAkxLg0miGT/Fs5v
 lHl5mKB31ICEZbE7xciKZ4eCy0xtwhhvkN+ebT+bwwZXJqLtYjR5xtM81qTcSiAAVxAGPsGi
 TeiLFI+jtvYmR3F1uJ03Hgpmpr4xBo3g/ClvdXzWmJaGliQ1ACji0YY+pV2m9dzhPPmTUcyY
 yBCJeItpGVDAj2mNTw1uXaAtn1NZP+ar+tRDI2545Ze2Y5a/SVmBipu2X3SXdAwa9KV/WfTw
 cy/hjCceKGjYQy+4X8ASgyYRvnsD214HVf9FGtAQERvVVFsqMwARAQABzSZNYW5hcyBHaGFu
 ZGF0IDxnaGFuZGF0bWFuYXNAZ21haWwuY29tPsLBhwQTAQgAMRYhBME201ChKFg6q5pu4tfs
 75O9CQInBQJpb1qJAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQ1+zvk70JAidKTA/6AualPRGS
 T0xGMmwLFgLTKJQb3WR7Xwm3PwSrNz3QI5RtEtMopZfSwllIA8I3wYCsF+0wmJQAuNbKx2Mn
 4FUmnUaq2QUzXlezTUe8nyeWAPbVNoJsgF6wxtzKvWjV9uXr2qRAjHm3gdFcxn2QgmPctJug
 x9emFXN6T+Hj9g0IIX+LbAI7A+cV/OFP+aZqLxnxIP8HlGfyf7zRh9HS7OPxDB7DyEH7pS2v
 UPCuE4j8uM4KqauzEVFoHzLCu+AVZs70yjGt61f2YAQsZBf+qFGPoy+nxWECW57YqDC47hdc
 PpfC8XBVyn5MsZc3iPxrP823fNWexq+Xf1C2tAGag+Z8+cZTr2OT7j9qPOPzvIbxEDBR8asl
 L6r6MnCsH0OiEcVkwvP8y+GYRKPPpCx81X9SAeoHTfc2Gy4nCEGmIEX3wU1bL+WzT/KgoTUk
 yzjse4jVL7KGQuqtGtYXibhmW0M+kWRd62A2OgSbi+gUqP5kztArIt1UUvCxe4VJ64vVe7oC
 K/tH191qdu2maPRzxSW2ZVxoP54URBu7IuSH/rZ/xsmTt+R2f1oygeEp7XdQyelS8EIEggwV
 mj/i873NfJytGlkW6zADAG7XEmDZWE5xSMRvL7+RxxXHEYhpOR/D9WsK06iMc0Rb2qtK5m6E
 IsiZfIg98B+hVJTJqfpzNDgtOHfOwU0EaW9aigEQAMudyGyXT4f6VnB9+5b7tgrzP/MWxgiT
 OI8e8iF8SfxYXbkkyfhKN0Cn+yzGOoaPSw7J/wziGqo2MwFs2nEgFJ5zpqBW+hMNqOdh+5DM
 5mcEuWS//Wjfm4rwJieFeZ3czCr/nqz7sAUOl/Dcew4RrqOTsA5XhCfZ0V6B9eZmPH1bseMF
 9rXqspjJJ98iQd9OHbjKkMgi8GTlPhxyml0xNzMIH1Os/G2i7LhVjS/Fvj+nF+SRWgDQfSdr
 T637cOh10IlTIrGw3L1ZOEExfUVNxjZi5Jn8kZUtAMouIODoxHpJ0l9vyyNoKaUitzJn+wug
 g0TFph/ZiP1RK9luS+UaB2iZAnNV0sPQwTLTeykt7ogGqmmjdaCQoF2mSCbUPJyvEmrUQjYZ
 OxSzALkTtBvWvvpRkgjJqaZ72DZkjvRD2iFEFXlfzTTxxT/r/3FgI2A3k8opsPm5NmrTYWO7
 FSVQMd8OXbMRov59VMP5v126iZoCVA+Da8cJroQmdqGhFZGGF9QvMkdik+/hDTjeBemicVUW
 WEJv0qyHaTmYgBVhAF3umFNX50Gi0cccT7IcrY78U44o/Xslehl/UEBPCjr4aZ2x/Ds4C4uu
 gHDysfIB6yLkKzQAjWHUEF7KOYY6O3reG4YJz1nTOaABdfRGra1rGa2r5Kj+j3ni8ZjVnYWt
 D0qdABEBAAHCwXYEGAEIACAWIQTBNtNQoShYOquabuLX7O+TvQkCJwUCaW9aigIbDAAKCRDX
 7O+TvQkCJ1wFD/0Z9qyn6z1zqiJRpBuvHbVEnVaRgj3eZK2K/5Ibk2ObbYZZfw9VvYbYcggY
 KS1IzwgdbKLRhjxReUHcbglCWPAoOJxctqTzEDwyZuff4kpWcyu8hW/1LyQOBv0fU1mml2B5
 1ioRqb0P6+PR1eMIjMmVI9HznXdsvhPecnEW85JgmzCF4pUUx0yM+IqCvFiR8cbgBf6HqlPb
 08Xkyb05F7KZms/NpkwfLCzwX+yr9PRQOJLXp648S85rvyJ2CVGeOiD8vf/bVg85XACVx6sv
 SI8qVcJJoJOpVKZsXhXoRhnBmlc8LCjY+ZPncEEEETtLQUeYUpEs0XVzOl3OwWVcuZy7QkAx
 WRZ04Q0j81jW91CIbvZvySLk7QuLE+27uAKQZzzsg8cduTuDLniFdbYzP0d2/s7gmKx2QU8A
 6x1anVhYhHihiipOFxoxqgIlE6+8hkI7/mq6lBvrjphU/7THrTQHiAeAFmwRRGR4q7JNHRiG
 yM7vvGT+amKOz4qucuWyTZ+to9qMrxfOcE21NW8TSMT2n119OsWP8z1m3mgx42L8ZF6yQ3jw
 iI3GWRgjoitqOO0ZIPdqgBGFOtnGURpityO7pOnwfpMRMZubktmN7TsCw5ntJ8Om7PrUOgZZ
 Dx+4ljyZOEEpzzJONCkA3cNXWiD8Af4E8yu+DtrpclEq76PP/Q==
In-Reply-To: <e68da695-2fdd-4692-999b-566c1b521f47@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261027-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ghandatmanas@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0619519AD3A
X-Rspamd-Action: no action

Hi,

I just wanted an update since the patch has not been merged yet.

On 12/28/25 20:54, Manas Ghandat wrote:
> 
> Hi Cong,
> 
> On 12/28/25 01:19, Cong Wang wrote:
>> We are reverting the check_netem_in_tree() code due to user-space
>> breakage. I hope reverting it could also fix the bug you repported here?
>>
>> See: https://lore.kernel.org/netdev/20251227194135.1111972-3-xiyou.wangcong@gmail.com/
>>
>> Thanks!
>> Cong
> 
> Reverting the above patch would fix the bug which I have reported.


