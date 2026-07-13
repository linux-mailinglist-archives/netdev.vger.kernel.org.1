Return-Path: <netdev+bounces-307226-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ttxdB0n6VGoviQAAu9opvQ
	(envelope-from <netdev+bounces-307226-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 16:46:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F7074C90C
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 16:46:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307226-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307226-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B16073165634
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47DB43932C;
	Mon, 13 Jul 2026 14:39:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC4E265629
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 14:39:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783953561; cv=none; b=PjiQwtoMROHky5cxsIx/W6+oyj+Bt6IFcSEQPqkWO63AP6r0i3LRNnVWCvOYhsEypp6ARMFD8P79ZqObkLcGHTvlopxuyl7bVW0AA2CSLuQ157sK+jmuWeoDggMVcqsORM2iqtyoUGiO3SHYsYBlP/jki00IgAmglKunlAmXgks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783953561; c=relaxed/simple;
	bh=7SVwThqf5Y8uGT7Wl/bLXED8qdBAA+y2a5is8Se2K/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZsOdp29Xk8OVzJ1x06GDVlYGXv7tkfkgH9Zf7X+coSkIKhou/8k3g2JYxO5+ZiGLi1seCqmVH11Ifue7DvEp/ccSf8sZiEAIUc9cttppBPDY9TjBR72HKWmmv9JHbL0FosNSmfe3CwKzNkmsLGjgPb7Amfx4gWIVbv6OcnRDtVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.139
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-493f17dc838so11128125e9.1
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 07:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783953557; x=1784558357;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ewxn1tc8oBqL++u0cfoxvHt4MAjgPzVty+SbSTp042s=;
        b=NJ1evmC2qgRUCdlCIGNhji1DvExNbpxhFOKwnQBz5kYo0XUzVAPLJDDFp9sFWJopZB
         RzIe2NACqF5wwpdo+9JQoUAsOf3FHKB6Gk2Wiqjb7RTpeHc+GZfK3GuZatbJ/3R+Mb2B
         lzCc+cmiHI+P6mV8VwNmtMQG+wYOJaIQkAeUOo9ezlwQkKKdWDjbdFkvdy04m2Jzqa7u
         e8G+Ewu2G2Mnqh+/RnULNItRTHVou2KaMnsvCsUYkvuBE4PqbjPd1DJehp2SecF3ZhwF
         TbCSyfCmhHa8F96O/T238nrch8vRz/0FKI4vk2qW3VuQCLVMTibYJ3gP7W3LRKn4AkO4
         Lv6Q==
X-Forwarded-Encrypted: i=1; AHgh+Rorm9kzRKpL/qhCNDdpGyV4rBf8LTS7uHuUnalKpQWB478VhKnN5Gd1kQ8/j8DfroDJVctD6y4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw0RJDx4wi7JCeNoDIpWJ9dPGnzG96LvfPZX3rXcesbfXhINA+
	X+hmLOQD/qeus5bDD28+ltjf1R7yFmBSSP3sdUbx9oYpfN53rKfkFhkL
X-Gm-Gg: AfdE7cmwgc/sXukNilz8nNJfRmx3f6H63LjFdTCLCjzZ3MBCpAUK9i5CeaBUMeQ3Iku
	a/lmCF/l1cre64mtvayMwJzhUHYHRPeoo1ZD0d0NpphEQGJDYP2n3NKRVJ3GYbyI6tBq8yieg+E
	VyNEG5TqX1LvC3chggidfNeHXskeBR2DlqO1Z8mSz0BWKz/c5tWROz7LWYM2bgMhH5q8befRWOv
	71GKKe8d5Iyt3prxJ1eQlj7OkxxAnz+4gOFg8rUnpb+3zVY4m+5Th+0j+igvhA9M98uzrNM9is8
	pa9G9/mlJs0lYyd015y3ZgGP55IeNFb7OR4+zQM++AN49IDU8eGiQIQX4Rhu1pm7sifhTgXY6VS
	rQZ+MhPbZa/Lf7/m1T7Q0uWcoipGvQ77aqJvIubpwHOwv7uOfLRg4E/Byc8i3DTErVyvC6LH6Kt
	nPza9XkJEOZgZ+8fTm1pcjoGxALJeOo3dfEOeowCwLDylR5SYm5w==
X-Received: by 2002:a05:600c:4e46:b0:493:efcd:b809 with SMTP id 5b1f17b1804b1-49401d2d054mr40539925e9.6.1783953556854;
        Mon, 13 Jul 2026 07:39:16 -0700 (PDT)
Received: from [192.168.88.241] (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f86556acsm185096295e9.1.2026.07.13.07.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 07:39:16 -0700 (PDT)
Message-ID: <f92c4b8a-601a-4e22-822a-ba00705fe60c@ovn.org>
Date: Mon, 13 Jul 2026 16:39:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] selftests/net/openvswitch: add SCTP flow key
 test
To: Minxi Hou <houminxi@gmail.com>, netdev@vger.kernel.org
Cc: aconole@redhat.com, echaudro@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, dev@openvswitch.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, i.maximets@ovn.org
References: <20260707034718.2717982-1-houminxi@gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260707034718.2717982-1-houminxi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[ovn.org];
	TAGGED_FROM(0.00)[bounces-307226-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:houminxi@gmail.com,m:netdev@vger.kernel.org,m:aconole@redhat.com,m:echaudro@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:dev@openvswitch.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:i.maximets@ovn.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ovn.org:from_mime,ovn.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67F7074C90C

On 7/7/26 5:47 AM, Minxi Hou wrote:
> Register OVS_KEY_ATTR_SCTP in the flow key parser so that sctp()
> can be used in flow specifications. The ovs_key_sctp class already
> exists (with src/dst fields matching the TCP/UDP siblings) but was
> not wired into the parser, so the token was silently dropped and the
> kernel rejected the flow.
> 
> Add test_sctp_connect_v4 exercising the SCTP flow key with
> port-specific matching: sctp(dst=4443) for client-to-server and
> sctp(src=4443) for server-to-client.
> 
> Wait for ncat readiness with ovs_wait instead of a fixed sleep so
> the test does not race against ncat startup. Use grep -c on the
> listening message to distinguish between successive ncat instances
> that share the same stderr log. Kill the previous server before
> respawning to avoid EADDRINUSE on the SCTP port.
> 
> Signed-off-by: Minxi Hou <houminxi@gmail.com>
> ---
> v1 -> v2: replace sleep with ovs_wait on ncat listening output,
>           kill previous ncat server before respawning to avoid
>           port conflict (Aaron review feedback)
> 
>  .../selftests/net/openvswitch/openvswitch.sh  | 102 ++++++++++++++++++
>  .../selftests/net/openvswitch/ovs-dpctl.py    |   5 +
>  2 files changed, 107 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> index 2954245129a2..9c364eeb2ec2 100755
> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> @@ -32,6 +32,7 @@ tests="
>  	dec_ttl					ttl: dec_ttl decrements IP TTL
>  	flow_set				flow-set: Flow modify
>  	action_set				set: SET action rewrites fields
> +	sctp_connect_v4				sctp: SCTP flow key matching
>  	psample					psample: Sampling packets with psample"
>  
>  info() {
> @@ -443,6 +444,107 @@ test_action_set() {
>  	return 0
>  }
>  
> +# sctp_connect_v4 test
> +# - sctp(dst=4443) matches client-to-server INIT
> +# - sctp(src=4443) matches server-to-client INIT-ACK
> +# - remove flows and verify connection fails, reinstall and recover
> +test_sctp_connect_v4() {
> +	local t="test_sctp_connect_v4"
> +
> +	which ncat >/dev/null 2>&1 || return $ksft_skip

Not a full review, but can we avoid ncat?  We already use nc in other
tests, using different implementations of the same thing in different
tests doesn't sound like a good idea.  On mnay systems nc and ncat
will be different implementations with different options and behavior.

Best regards, Ilya Maximets.

