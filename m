Return-Path: <netdev+bounces-255780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGuHE6xjgGml7gIAu9opvQ
	(envelope-from <netdev+bounces-255780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 09:43:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A94C9C49
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 09:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 984DB3018BC1
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 08:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF84C27145F;
	Mon,  2 Feb 2026 08:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OYgd+Zwu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsEb/PMk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF80296BBA
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 08:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770021526; cv=none; b=MVacz+XRp+rIaPG7UD2wszCSB94IQsKCNCnsPTWEWv6aKaTe8XcicMzbPhDvEpyE6+mNxcuTVzPm9//osERymDs0kOtupwG0Z9kvPG/FN+GFJoSVuyfg6TEg45e97fXwqAgyI6yWAh9V292s6HjOY4r961E0tSUYs0qk+R563ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770021526; c=relaxed/simple;
	bh=217dCEjP4xzP6JJ/pCSzmY/4sbxNR6Nc3X2BXnsH5M4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iR/Eob82pCSBL9T/1IHG40ne4s8OKYS+tS/0Arm/ANL5E2aOw0soZHdXadFWvwsx60S4197XoMuT8VNQeEiORf2hgsJD8QaN7aCS8Aik51mOmX71kP0wWrEONaYE6IEtxW6b0d3tol2Xa7DaXhc+ZLWNaoCAtTVWMMMfy7YDpBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OYgd+Zwu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gsEb/PMk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770021524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=43FkWE7of0BopE+Cefop92t49ZPnZzlo7pONPSXSZWE=;
	b=OYgd+ZwuX/beFRjbRbbGSd1paaVlBhLBfcolPIMWN9NrW02ZmENShWOnTedWyLukVC+0he
	j9eIRcQqn+CGfHbdamn6ZpoEf2x5jRxubuymTay10dXivm1PGGj0kQK0Jc4WSazesESwnS
	C5nQaQZDx6M8MqXtbzoXj1U+UnKGniw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-nG101v99PlOeSLtnfLzKRg-1; Mon, 02 Feb 2026 03:38:43 -0500
X-MC-Unique: nG101v99PlOeSLtnfLzKRg-1
X-Mimecast-MFC-AGG-ID: nG101v99PlOeSLtnfLzKRg_1770021522
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-482eec44485so12870515e9.3
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 00:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770021522; x=1770626322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=43FkWE7of0BopE+Cefop92t49ZPnZzlo7pONPSXSZWE=;
        b=gsEb/PMkqxESfN5hpwDlK8M10222HU3GJnsq4Do/qAFAiG4FiiPkLHsn/pkTQfJMyF
         2IH+O2OndPIFKfgGSh8A4sHTu0dGgPwaeke8vYLSQOeUdPdmxX8YVfQyuK3xfZTYOSRy
         HMsdTGqjIL+KLzykiJNdfk58z2GoY++//M9t4Z6Qc0P/ijtz28LB6VZJ7q4z8+okkm2V
         8tQLkX2Jlo5Z/LUb7UjMVEO/0TYwKnaYnZlxaTBmW5qN/xzAJrObJ5PBoRw39pADFYmc
         hYR5iXGI9zJOo1g9AlvCepS5JBFqP9CkIETxmcFBasu0cqxhXWOTA4qmnUIEg6mZ5QHh
         Da6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770021522; x=1770626322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=43FkWE7of0BopE+Cefop92t49ZPnZzlo7pONPSXSZWE=;
        b=v+h9EidkUxjksAJTfqQhOLtp0fldeu+BErGhYhB4SA4LBvH000IKMH+MFhjwTdR37e
         VPCKgH8PBdj52EzH3sHUmQJySmD6Zxa3Yi9Ogdl/ujUTiIoLlFqa47dMQLNNZGOxsklJ
         mChN9yR4ojW6vKYTUsq5A7Bhc1aeXEVdrywILvqsgMV+udysOcisDBf3D5QOMVTbZl9L
         ceREXGIxhF/Vbe9+zu68ZDrPC1aUj6K+stlElax5KqzCNPwtqfNnRd5Dek2DYTeuuMpi
         nX8bUJovHpcSgm+VAU/zePIzMV6rVz4baT9Wyw0jvRLkWF0XzUKDgD2+AImymLeyGSLV
         fbuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjr+Mt4nxV9AJAqZ4UfiXTAbsntn0FqZ+Qbn7WYJdFtiZkORMldOigkti3yCkj/0Zr1x/xLvA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0g8NNFB218ZWqHICzJiv/JmhwdebH2b3VlYzBKcBIicHUDB26
	3sccf4JIV74mcN93U8yIj/DyD9NF4VBxoTzeEa/9+p/Ft5Vh8aw57DErQ/pHBmtHGpRWWct2i6p
	vd3VdgOlcPVtw1WtWKi9Ib5hWjYy+7dic0UvPw2T/LmRnVQPGwTHCxEJ4TQ==
X-Gm-Gg: AZuq6aIE/kGk5G2Zwmngzu3wh1Lto9ScmAZcLheP9FEHVFNndh6Ui2uPJg8DMH++1lB
	9rfgfs+lR+6V5Mbak0jC7gLHQieBPdPn4mxh+rd6ANinycYwFgmV9vcxaZDlQ0QIZr2gbcFv5wB
	EHo+CqLaKWzD7OZtX8DCGkLT127OvaiEM9LI8SZeQGhmOu/fgsl+qENqdMFkgiYfsa5tkTcBX/P
	1Fs0bNI5ZRCLJC9bYdEY492+RbzXSzrcg/UClfCBaVmrvREYNq1IgvKeg7+SWN1/GvyyK7OpZxr
	8RJdg1aheGSOkyJMcf7BgaZJ6ge7BbQSX13vN8PKYwmDNm6XOKhILk/iBSiJ7PbF97WuHqcSFe0
	ygNsCd+laRu4=
X-Received: by 2002:a05:600c:1d23:b0:45d:d97c:236c with SMTP id 5b1f17b1804b1-482db47d46dmr127034095e9.21.1770021521842;
        Mon, 02 Feb 2026 00:38:41 -0800 (PST)
X-Received: by 2002:a05:600c:1d23:b0:45d:d97c:236c with SMTP id 5b1f17b1804b1-482db47d46dmr127033855e9.21.1770021521458;
        Mon, 02 Feb 2026 00:38:41 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066bee687sm673189845e9.5.2026.02.02.00.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 00:38:40 -0800 (PST)
Message-ID: <d59cb0a5-567a-4422-bd91-b85cc4130e78@redhat.com>
Date: Mon, 2 Feb 2026 09:38:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] selftest: net: add a test-case for encap
 segmentation after GRO
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Willem de Bruijn <willemb@google.com>,
 Richard Gobert <richardbgobert@gmail.com>, linux-kselftest@vger.kernel.org
References: <cover.1769771825.git.pabeni@redhat.com>
 <276270cf825431817e46f6744d9b26d3ea954869.1769771825.git.pabeni@redhat.com>
 <willemdebruijn.kernel.14968a7a11ed8@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <willemdebruijn.kernel.14968a7a11ed8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-255780-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A1A94C9C49
X-Rspamd-Action: no action

On 2/1/26 11:19 PM, Willem de Bruijn wrote:
> Paolo Abeni wrote:
>> @@ -260,6 +293,38 @@ for family in 4 6; do
>>  	ip netns exec $NS_SRC $PING -q -c 1 $OL_NET$DST_NAT >/dev/null
>>  	run_test "GRO fwd over UDP tunnel" $OL_NET$DST_NAT 10 10 $OL_NET$DST
>>  	cleanup
>> +
>> +	# force segmentation and re-aggregation
>> +	create_vxlan_pair
>> +	ip netns exec "$NS_DST" ethtool -K veth"$DST" generic-receive-offload on
>> +	ip netns exec "$NS_SRC" ethtool -K veth"$SRC" tso off
>> +	ip -n "$NS_SRC" link set dev veth"$SRC" mtu 1430
>> +
>> +	# forward to a 2nd veth pair
>> +	ip -n "$NS_DST" link add br0 type bridge
>> +	ip -n "$NS_DST" link set dev veth"$DST" master br0
>> +
>> +	# segment the aggregates TSO packet, without csum offload
>> +	ip -n "$NS_DST" link add veth_segment type veth peer veth_rx
>> +	for FEATURE in tso tx-udp-segmentation tx-checksumming; do
>> +		ip netns exec "$NS_DST" ethtool -K veth_segment "$FEATURE" off
>> +	done
> 
> fwiw, tx off will disable all the dependent tx offloads too

Going over the features in this order is intentional to prevent ethtool
from emitting messages about the additional features disabled by
tx-checksumming.

>> +	ip -n "$NS_DST" link set dev veth_segment master br0 up
>> +	ip -n "$NS_DST" link set dev br0 up
>> +	ip -n "$NS_DST" link set dev veth_rx up
>> +
>> +	# move the lower layer IP in the last added veth
>> +	for ADDR in "$BM_NET_V4$DST/24" "$BM_NET_V6$DST/64"; do
>> +		# the dad argument will let iproute emit a unharmfull warning
> 
> unimportant but minor typo: unharmful. Also above aggregates -> aggregated

These ones were not intentional :)

> 
>> +		# with ipv4 addresses
>> +		ip -n "$NS_DST" addr del dev veth"$DST" "$ADDR" \
>> +			nodad 2>/dev/null
> 
> nodad probably only matters on add?

uhm... yes, left-over from c&p.

There is no rush, let me send a v2 addressing the above. Thanks!

Paolo


