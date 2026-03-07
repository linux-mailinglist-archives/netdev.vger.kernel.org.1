Return-Path: <netdev+bounces-265173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id khjmFheDrGk1qQEAu9opvQ
	(envelope-from <netdev+bounces-265173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 20:57:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A52A322D6CB
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 20:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 445AA301DE09
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 19:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD9C33C198;
	Sat,  7 Mar 2026 19:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g/W15PpL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFDE3A257F
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 19:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772913270; cv=none; b=LWTkLsTygKyW7vmA8iEXPbO/EZl8DCCEG4U57ggJnMwgosdfYNaZUO/YNq13+zUQHOAIJcqC2kqTF9i+oGBSHjDY8x8aYeLVjvekM5yArDaq56j2O7beFNFWIKshpivyIgXQP/Df99d3RU1rFnlHzdoEtiPvKYoeiYJXtB6JY4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772913270; c=relaxed/simple;
	bh=1y3sIRO+i9mMyJAEIpsi5HHAo6pg1KHpSiMVhy4nVYk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=pyWhYcKv/XAxaaNpyr1QgDCJ3LyxkAqn7hXJYDqy3oj8Lm36a36ROzzRjiuQacTAFP2p/HfumrFzZ/Qsp/UnONfdcde66V7neSh8Gyw2q4jI4E6nKQfo0Rbdb2rpBhFLKD+SqKlK56mXZCU8HBf7ia1mlCAzUQrkau7e3Z5rv4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g/W15PpL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-482f454be5bso105524695e9.0
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 11:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772913267; x=1773518067; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRapRrMQzfVb1zc8bjuWvKtij1EZN6NyZd+CGQgeUqY=;
        b=g/W15PpLYwevvKhlFNQMj8vDmrLs6bnDdNjvdRwldmaau4ruLQ9TG6xRkiyCHqzwu6
         7xFUqz4O8LyQanSHBuiWo5moUnQsBGP7NumZQvshTWRcersdQLEgMQem5MXec3g2KLZI
         nWTobCt3XFoaHPgaYl8IegcnrhaEUmcjC3bsCuWSwc7PAUdqoQ78SlW+ERyacZrv6QOh
         E9+7kFyRdE7mpDtH0Z1yQKuR1m8J07glTMHtNjVBtuHeoQYVQFsJhfcPD9Zt66Q7SFqe
         /34ts4qxVxFdb8tQQfhehHrEOpjd/vzPwrEwpJ6+1l8psaJ4vH2GDlArRnkIvLPN4H6r
         478g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772913267; x=1773518067;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wRapRrMQzfVb1zc8bjuWvKtij1EZN6NyZd+CGQgeUqY=;
        b=p0+K8mf37GkZ0hevkBSCeYCwMyMgPNfIe45WQIVI96d9htiqy8H1nGW2FPLtBCkXLG
         KpVUCGO8kRQ65mKLAww9OAn6Avn59UafOxkeSB280cTvjMvQuPYFsm5mB4ygjFUeCABu
         DJLXgWOB2aMFRdphpXwBdFBfjhUT94t/jFoHKvAcqprSGlRf3k0IqIUtkf5rhokgGgwB
         was00P2KDh1KCQEfgX9761cGcqQesjTIGqSMwdsx2ZeWgtnUlQHfboS0bk4vDdAb4z2Y
         gxZnBkRwXzY115dvI/Y5sg/eJEdB+hYSaPaxKMg9jIGU19DbaHuWW+e57IgVZs2RA9KH
         dNZA==
X-Forwarded-Encrypted: i=1; AJvYcCUE4EMKkZQYZ32q+VdjdesbViDCrlU2/palTrggGol2nFY3ji7xLxWHh8r3cprv/V9XEmE3Rfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7P6+CjfxQQz3RonAl9eUr1eXGaziAuVPFZ7hKHuL0lB9IeA6k
	zWvIbUAPXw1eT2j5f/eZMkZzw2VGBN9sRnZpPr95xuFFQRRz/SBt9s0A2FP64aBoBFU=
X-Gm-Gg: ATEYQzx3bN7+zpLfYvlrEGiReo9sdW8WI8BJUMMscbeRIe6v+UFGsIwpg4N8wCLNLzK
	yNR23AOWP0GFzg/7m2xTR2UfZtat7Me6AU6jWCbi1qbdEuH4P5oDI2T2kDvzM1BLXiqgh2Hzzdb
	HMDwTb6eSGPaU31Dk2s1BbxgO6dFsoE7LzNIq2HWDkKzjr1Y1zh/FVYRWAwAOuKhAvFmEtKVky/
	tSDzZIg8V/GpnperswZ3B4QKmM1kIlt50hdP4CzHMM2peMmgPpff5liWqpK6xUYsOalS3HdEESB
	3l6zgySrIf3rN77+B7Dd3SLs9L6kbWMmwsEVd0ivJZbFfOLPfl4emYNadVotaH2RhSS9NB7vivF
	mhP4YgeDT4zFeAWbays30BBYqS+4j2eb9gZljgOo/eWHRmMAR01ZFPBdjuOCWDq9Um2v2vLGpUU
	pUv2HWUvKJug==
X-Received: by 2002:a05:600c:3e0b:b0:47d:52ef:c572 with SMTP id 5b1f17b1804b1-4851ee6a3fcmr176036785e9.1.1772913267309;
        Sat, 07 Mar 2026 11:54:27 -0800 (PST)
Received: from localhost ([189.99.238.164])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94e7b57ec19sm5145450241.14.2026.03.07.11.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 11:54:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 07 Mar 2026 16:54:22 -0300
Message-Id: <DGWTAT5RG00Q.3OB5QRCWISVA5@suse.com>
Subject: Re: [PATCH net v3 2/3] bpf: bpf_out_neigh_v6: Fix nd_tbl NULL
 dereference when IPv6 is disabled
Cc: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>, "Martin KaFai
 Lau" <martin.lau@linux.dev>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "John Fastabend" <john.fastabend@gmail.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "KP Singh"
 <kpsingh@kernel.org>, "Hao Luo" <haoluo@google.com>, "Jiri Olsa"
 <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman"
 <horms@kernel.org>, =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@redhat.com>, "David Ahern" <dsahern@kernel.org>, "Jay Vosburgh"
 <jv@jvosburgh.net>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "Hangbin Liu"
 <liuhangbin@gmail.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Fernando Fernandez Mancera" <fmancera@suse.de>, "Jakub Kicinski"
 <kuba@kernel.org>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
X-Mailer: aerc 0.21.0-120-g0a16d1784be2
References: <20260305-net-nd_tbl_fixes-v3-0-fde28b30a744@suse.com>
 <20260305-net-nd_tbl_fixes-v3-2-fde28b30a744@suse.com>
 <20260305182521.0ca7313c@kernel.org>
 <b3477010-6fdd-4bec-8951-152b12bf56e6@suse.de>
 <20260306183914.4b13a03d@kernel.org>
 <691d5589-46ea-4947-9510-bfd9d991ed02@suse.de>
In-Reply-To: <691d5589-46ea-4947-9510-bfd9d991ed02@suse.de>
X-Rspamd-Queue-Id: A52A322D6CB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265173-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,jvosburgh.net,lunn.ch,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rbm@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat Mar 7, 2026 at 4:27 AM -03, Fernando Fernandez Mancera wrote:
> On 3/7/26 3:39 AM, Jakub Kicinski wrote:
>> On Fri, 6 Mar 2026 10:58:44 +0100 Fernando Fernandez Mancera wrote:
>>>>> +	if (unlikely(!ipv6_stub->nd_tbl))
>>>>> +		goto out_drop;
>>>>
>>>> So neither Fernando nor you checked whether this code can be built
>>>> as a module? ipv6_mod_enabled() should work just fine
>>>
>>> I checked it. If IPV6=3Dm this is not fine.
>>>
>>> ld: vmlinux.o: in function `bpf_out_neigh_v6':
>>> filter.c:(.text+0x3231d60): undefined reference to `ipv6_mod_enabled'
>>=20
>> Guess I got it backwards :/ Should we add this to the series?
>>=20

Nice, thank you!

>
> No worries.
>
>> -->8--------
>> Subject: ipv6: move the disable_ipv6_mod knob to core code
>>=20
>> Make sure disable_ipv6_mod itself is not part of the IPv6 module,
>> in case core code wants to refer to it. We will remove support
>> for IPv6=3Dm soon, this change helps make fixes we commit before
>> that less messy.
>>=20
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> ---
>
> Ricardo could you add it and check if it is fine? FWIW; I am sending=20
> today the series removing IPV6=3Dm after some testing to net-next tree.

Will do!

>
> Thanks,
> Fernando.
>
>>   include/linux/ipv6.h | 7 ++++++-
>>   net/ipv4/af_inet.c   | 6 ++++++
>>   net/ipv6/af_inet6.c  | 8 --------
>>   3 files changed, 12 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
>> index 443053a76dcf..e5b6853d517a 100644
>> --- a/include/linux/ipv6.h
>> +++ b/include/linux/ipv6.h
>> @@ -333,7 +333,12 @@ struct tcp6_timewait_sock {
>>   };
>>  =20
>>   #if IS_ENABLED(CONFIG_IPV6)
>> -bool ipv6_mod_enabled(void);
>> +extern int disable_ipv6_mod;
>> +
>> +static inline bool ipv6_mod_enabled(void)
>> +{
>> +        return disable_ipv6_mod =3D=3D 0;
>> +}
>>  =20
>>   static inline struct ipv6_pinfo *inet6_sk(const struct sock *__sk)
>>   {
>> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
>> index babcd75a08e2..f1944e8fd9d3 100644
>> --- a/net/ipv4/af_inet.c
>> +++ b/net/ipv4/af_inet.c
>> @@ -124,6 +124,12 @@
>>  =20
>>   #include <trace/events/sock.h>
>>  =20
>> +/* Keep the definition of IPv6 disable here for now, to avoid annoying =
linker
>> + * issues in case IPv6=3Dm
>> + */
>> +int disable_ipv6_mod;
>> +EXPORT_SYMBOL(disable_ipv6_mod);
>> +
>>   /* The inetsw table contains everything that inet_create needs to
>>    * build a new socket.
>>    */
>> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
>> index 0b995a961359..03c175cbbdb6 100644
>> --- a/net/ipv6/af_inet6.c
>> +++ b/net/ipv6/af_inet6.c
>> @@ -86,8 +86,6 @@ struct ipv6_params ipv6_defaults =3D {
>>   	.autoconf =3D 1,
>>   };
>>  =20
>> -static int disable_ipv6_mod;
>> -
>>   module_param_named(disable, disable_ipv6_mod, int, 0444);
>>   MODULE_PARM_DESC(disable, "Disable IPv6 module such that it is non-fun=
ctional");
>>  =20
>> @@ -97,12 +95,6 @@ MODULE_PARM_DESC(disable_ipv6, "Disable IPv6 on all i=
nterfaces");
>>   module_param_named(autoconf, ipv6_defaults.autoconf, int, 0444);
>>   MODULE_PARM_DESC(autoconf, "Enable IPv6 address autoconfiguration on a=
ll interfaces");
>>  =20
>> -bool ipv6_mod_enabled(void)
>> -{
>> -	return disable_ipv6_mod =3D=3D 0;
>> -}
>> -EXPORT_SYMBOL_GPL(ipv6_mod_enabled);
>> -
>>   static struct ipv6_pinfo *inet6_sk_generic(struct sock *sk)
>>   {
>>   	const int offset =3D sk->sk_prot->ipv6_pinfo_offset;


