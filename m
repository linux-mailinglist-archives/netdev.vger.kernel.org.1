Return-Path: <netdev+bounces-275648-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMakAfji02nIngcAu9opvQ
	(envelope-from <netdev+bounces-275648-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 18:44:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6613A5674
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 18:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06444300F529
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 16:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAC838B15D;
	Mon,  6 Apr 2026 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Oc3zTf6o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C098A7083C
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775493845; cv=none; b=FX0ebWpuXA+3aizlR9iamXxTCA6gK95EMpZDOPY68S6HH3XpW/kLMvajTrj2OJOdjYDsgeaaHrZnqlP3t9Snqyyiyn9BN7uYh3/7ix9bFGBz+rb5RMLHT0GVkASk23lIHV0Do45Fg80Uf7k/6NXXMq924mAG2GYKf4Pmn0XGi10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775493845; c=relaxed/simple;
	bh=REc/vRgYW4cmwtP9hav5H1QyEg1NfxHK7rgjynKWbZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cOE+eJOk5+KE0Wm0JfJI4DttsbG/0k3O1Nx6UGEDR0pXZ3AqejhPE409ZYf619MDoxZ5DjH3pShCMG8gVXSHxIsdLsW6w2VFv+pGklWboBvh6H/oRA+LhhbSDx/SyNFQ28NbUy2+wheK4xjJDp5ZfycplzS1J5QK5CQ810dlQ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Oc3zTf6o; arc=none smtp.client-ip=209.85.222.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-8cb40149037so473054085a.2
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 09:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775493843; x=1776098643;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YaGqfE5XR7b6uHH8ytXdqGCyL58z+YbazBoW6b8pwfs=;
        b=UooE770NkW2cO/BSngQN2Tdy2J4nmaPGNStdRK8Mz9v8qieF/370kLx8itHwNOV/R3
         5zgMu912OlRoJGPZ9vuGvtMbeDSrYj+yijiV0Xo53jCQIwrxvEQyVAWNhf3kjEJXcGBD
         zofWUJPT5kc3GnTEnT9jxc78Ihe9cMGYDziJ9xoBidwPDTtwO5LQnepIz6yejRnGtC5u
         emJ0648CwcmzkJ89hyYbbySnMevyCDClWR5mIzSi+66F3/yFY9767sdOrGOSLO74B5tf
         9uxMSjCCFd85O3AVFP0gB2LN/e+3884TKUh4b0w/2Gz9i3DuY1Z8yRw/RsOA0+S9qbD+
         5Ofg==
X-Forwarded-Encrypted: i=1; AJvYcCUxFJNIs44OmBjzba/ywkyfuVxXDyYulm2M6FqqZIg1Gm5rSNbICx7f/d6ufc7Sio/Fs5amQrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YynHi1p/niAF8maRFXQqmo+YqFsFH4xLEmqWLgMFBSmXX4DQ5lf
	7JWqMdBO2QWtmeV+Yd8oMf66AuojCjAd7enbOyzFzI6tyw/k4+TcRIKL8cbDshTGgTpOvLUzI/Q
	ap5HD1xBE+rTVC0UnCgEE/Z5jC/7J/eIB+ouwGb5kBMScHl/vE9t8Suw2bPYoZGHtgHcbY/CvwN
	e/A3B76ipdKsVZdnAwioTR949wRZGi4/ezJ3YCrQbgmhA6sds/T9jpMN22UfHLzGDFqcVSbzJ9o
	gcYmHH5Iet03WW9
X-Gm-Gg: AeBDieuav//lFWyVlEcpX9Rh1RI0VTaoFPvqfYrF2lS+P1fDGhXGZHTAYq6+0TBoNgb
	iq4oV3HgIpOzTeInwrr+lKTmdLavETw8Wt8NwK6vye3rMJcwfDL9ZJaY9BlRj18mITnchOTS/5I
	EetmgyaM5UtvjWy4uKThYnW/v+7r0eRrm/VzxWee5BC3PvMr16tgN6dKKP9cqI/CHUVGDMKLoSv
	CCvHlUaxJMOnT0J2tKZ2nTh3hdfyeX3x701g2iOvBkzVRFrUZqmKgaEASoI1De5sYwBNwOcwixq
	AcIa0dY5vZkclxYPCn7hyiz/6Rul9k/qsBhRRMw5FGiMKS4xzP6oyAXZxl9AtCIMRPmaF//TQuu
	FMFr852WK0TrzriUc3Yd1LFflM/QoOksbxaFV2Izr8OLNw8fEBQOs1Hh/xVtZNVGcVWIpidE+rK
	fef3K7hzEOJi5oZmlIoEEGkHrOgquEeFaXSomcRXmvodaOw/+3ToHGRfwf+z+Vpw==
X-Received: by 2002:ad4:4ea6:0:b0:8a1:5a62:f672 with SMTP id 6a1803df08f44-8a7042f8995mr208109556d6.30.1775493842594;
        Mon, 06 Apr 2026 09:44:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8ab9acdebc3sm1237356d6.8.2026.04.06.09.44.02
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2026 09:44:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso49044035e9.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 09:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775493841; x=1776098641; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YaGqfE5XR7b6uHH8ytXdqGCyL58z+YbazBoW6b8pwfs=;
        b=Oc3zTf6omkmTzs/Db85ph2X7ZpAdz6LLTw+tuK8/ldYVRmXLQHHE0ebJSh2RJzyCD/
         5MNugBpRU73Ww1PL5B//9ykkQLBmrPLDZ1UJbl9vL+J+Uvh0RYV++hhbZAEMx2AViCJZ
         6l9WtBXhcsXLnA+3bKyStXIz8N0G6s2d9o2sY=
X-Forwarded-Encrypted: i=1; AJvYcCVMOE4ZLc8T0cL97Wsqgqjiopnde40s9oYvAFx/sVhmiapCEwiM8VPM/Anl7sr27f/ydtNqBSI=@vger.kernel.org
X-Received: by 2002:a05:600c:4593:b0:485:3423:727d with SMTP id 5b1f17b1804b1-488997dec19mr206968855e9.26.1775493840858;
        Mon, 06 Apr 2026 09:44:00 -0700 (PDT)
X-Received: by 2002:a05:600c:4593:b0:485:3423:727d with SMTP id 5b1f17b1804b1-488997dec19mr206968305e9.26.1775493840375;
        Mon, 06 Apr 2026 09:44:00 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48899d3a4e9sm192703635e9.6.2026.04.06.09.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 09:43:59 -0700 (PDT)
Message-ID: <cdef227e-9dfe-4860-aca3-5ce1f60cb838@broadcom.com>
Date: Mon, 6 Apr 2026 09:43:55 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] net: phy: add support for disabling
 autonomous EEE
To: Andrew Lunn <andrew@lunn.ch>, Nicolai Buchwitz <nb@tipi-net.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260406-devel-autonomous-eee-v1-0-b335e7143711@tipi-net.de>
 <a1cf8f6a-b338-4dd7-aced-7e19e4d0fdb7@lunn.ch>
 <9272c5dd653039b3def8caaea3e631c5@tipi-net.de>
 <5298959c-12de-4992-a896-3d1371cba111@lunn.ch>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <5298959c-12de-4992-a896-3d1371cba111@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:mid];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275648-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5A6613A5674
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/6/26 06:56, Andrew Lunn wrote:
>> "Autonomous EEE" works for me (obviously). It kinda describes what
>> happens (the PHY acts autonomously) without being tied to a specific
>> vendor's marketing name.
>>
>> That said, I feel Russell's argument that it doesn't type well. But
>> even after some walks in the woods I wasn't able to come up with a
>> better name yet.
> 
> Yes, naming is hard.
> 
>> I don't think there's a meaningful use case for letting users choose
>> between the two. Or is there?
> 
> This has come up before, in other context. PTP is one example, where
> both the MAC and the PHY can implement it. Ideally, you want it to
> happen at the PHY, it gives higher accuracy. But there are systems
> where the PHY implementation is somewhat broken, and the MAC PTP gives
> better results. So defaulting to PHY PTP is not always the best
> option.
> 
> I would expect IEEE 802.3 EEE, with both the MAC and PHY cooperating
> is better than just PHY level EEE, the system as a whole has a better
> picture of what is going on, so using 802.3 EEE should be the
> preference/default. But are we going to run into oddball systems where
> autonomous EEE is actually better than using a somewhat broke MAC?

That is almost a guarantee given, there will be a broken MAC, and there 
will be a need for enabling EEE at the PHY level because the power 
savings can be significant. Until that happens however, I would agree 
with using the global "--set-eee" without differentiating, and if we 
need to disable MAC-level EEE and switch to PHY-level EEE then we cross 
that bridge when necessary.
-- 
Florian

