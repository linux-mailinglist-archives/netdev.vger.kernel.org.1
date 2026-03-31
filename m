Return-Path: <netdev+bounces-273619-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKISH+PFy2mnLgYAu9opvQ
	(envelope-from <netdev+bounces-273619-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:02:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B33B9369E3A
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9192130C0DBF
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 12:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A163E121C;
	Tue, 31 Mar 2026 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moehl.eu header.i=maximilian@moehl.eu header.b="H98hOVxc"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CC33E2771;
	Tue, 31 Mar 2026 12:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774961446; cv=none; b=blGbCIa9AImtRaq8hP6MKpHnWe63mWlLVRXr5oL3AhBM53LufzyFFHcptCgnI9qbyJaAASWRt1KYeqfm/rnfoI+yLeG9YJdEOeb0e7s8i8B0UpzPlbJvGYNTGrCjWwsr8dwQWxif3kb4wYTlTKj71blc18j99QmzqGs3ZK/yZtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774961446; c=relaxed/simple;
	bh=Ao1wR4vKUq+yJSFL5sq/8rGqTsRaunaLuUjL9xEdKHg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=AtMEaGJM++NDBzErCf9gvoEYvx0ecsWZV4eR8UpMJEbo/8KC7ZAH2SHroyzwlRo/jnYH9OHQTe7QB+YPSh76kfj57CCei3pCblRPLl9HZ+7Pf/r5yCDZP0jlVAVpZULFzk1opA4j2jR6AnX67FbtnJr9CCBttU9zhS6X8x4rZNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moehl.eu; spf=pass smtp.mailfrom=moehl.eu; dkim=pass (2048-bit key) header.d=moehl.eu header.i=maximilian@moehl.eu header.b=H98hOVxc; arc=none smtp.client-ip=217.72.192.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moehl.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moehl.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moehl.eu;
	s=s1-ionos; t=1774961437; x=1775566237; i=maximilian@moehl.eu;
	bh=NoOH9Gn2mNSPkTArDrZrVLwFlsp6pgj6rci8Sf5S3F4=;
	h=X-UI-Sender-Class:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=H98hOVxcE7WG2EwYzo5dN9AzoYubMJWUKaaNn7OV6ixDnRlLxui9at953VRX2obv
	 k56PrB00UMnYIwecX3ik2N0mvcx1hbyiCfEriD/+FE9fkTMOYRryNKA5cfXRPOAu4
	 AMbwgrfVIGs3BJNAwyCChKs75EclvpIj1Vm4x9KiCLkVxy/K7DZDXeJvFw+jsj77X
	 QDv4zQlEOGlYZoASzB+vO6bdtnmr19AM8OsATEZIHMvbns+9hTzb5MePxD7uCRSCB
	 GYmKM3h9ShTDhqhCb8dpVIZrAITOWjBE7N79fYCCEjVBvE20ez3aoAPqWRK/nb9uU
	 14Ov5IGpTJ/llGUwvw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue109
 [212.227.17.181]) with ESMTPSA (Nemesis) id 1Mzhax-1vKh9Y0bTt-00uU6Z; Tue, 31
 Mar 2026 14:50:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 31 Mar 2026 14:50:35 +0200
Message-Id: <DHGZBEMZ25SW.3LE7U694ND0L0@moehl.eu>
To: "Paolo Abeni" <pabeni@redhat.com>, "Maximilian Moehl"
 <maximilian@moehl.eu>, "David S. Miller" <davem@davemloft.net>, "David
 Ahern" <dsahern@kernel.org>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Simon Horman" <horms@kernel.org>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net/ipv6: repeat route lookup with saddr set for ECMP
From: "Maximilian Moehl" <maximilian@moehl.eu>
X-Mailer: aerc 0.21.0
References: <20260329091201.63646-1-maximilian@moehl.eu>
 <f73c3cf9-18e9-4109-b173-d6000cb0cf88@redhat.com>
In-Reply-To: <f73c3cf9-18e9-4109-b173-d6000cb0cf88@redhat.com>
X-Provags-ID: V03:K1:UVTvV9dbrg7VtSoTG8aJnzgUEr8OWwYOmX/FtxxwltUVfrovBJD
 4uFdAKtXgEsZ2wi0Pd2gygE6RvcL89DFeZKjBLKEvScA3vqLi6rr6mgKSlx3Lb8qz9oGXw6
 d9H7zSdu5G47mk2KlOoshLzlDCBFFKq8nhthURQm+uZZMw8KAVwDNQN3jhlKGnv4b0XU/8F
 iqgOPo+k8KinTdJVO1Z1A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:slyXPfNwS/M=;brALiqROAcETzmH6jgjc1lrDd5y
 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
 2nw8q2YNs27JHML8SMqWbE7keslCk=
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[moehl.eu,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[moehl.eu:s=s1-ionos];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273619-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[moehl.eu:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maximilian@moehl.eu,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,moehl.eu:dkim,moehl.eu:mid,fib_tests.sh:url]
X-Rspamd-Queue-Id: B33B9369E3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon Mar 30, 2026 at 9:56 AM CEST, Paolo Abeni wrote:
> On 3/29/26 11:12 AM, Maximilian Moehl wrote:
>> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
>> index 8e2a6b28cea7..465fce51d017 100644
>> --- a/net/ipv6/ip6_output.c
>> +++ b/net/ipv6/ip6_output.c
>> @@ -1148,6 +1148,18 @@ static int ip6_dst_lookup_tail(struct net *net, c=
onst struct sock *sk,
>>  			*dst =3D NULL;
>>  		}
>> =20
>> +		/* If ECMP was involved the initial hash was calculted
>> +		 * with saddr=3D:: which can result in instability
>> +		 * when it is later re-calculated with the selected
>> +		 * saddr. Lookup the route again with the chosen
>> +		 * saddr to get a stable result.
>> +		 */
>> +		if (fl6->mp_hash) {
>> +			fl6->mp_hash =3D 0;
>> +			dst_release(*dst);
>> +			*dst =3D NULL;
>> +		}
>> +
>>  		if (fl6->flowi6_oif)
>>  			flags |=3D RT6_LOOKUP_F_IFACE;
>>  	}
>
> This apparently breaks ipv6 fib tests (fib_tests.sh):
>
> # IPv6 multipath load balance test
> #      TEST: IPv6 multipath loadbalance                          [FAIL]
>
> see
> https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-=
style
> on how to reproduce the tests.
>
> Also this would deserve additional testcases.

Thank you for the pointer, I will look into the tests.

> Without diving much inside the code I have the feeling this change is
> plugged into the wrong place: multipath selection logic should be
> encapsulated by fib6_select_path().

To be able to move this logic into fib6_select_path(), the call to
ip6_route_get_saddr() would probably have to move as well as we need
to set the source address after the first lookup. This would then also
set the source address as a side-effect.

I can give this a try, just want to confirm that it's the correct way
before doing so or if I'm missing something.

--
Max

