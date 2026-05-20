Return-Path: <netdev+bounces-289948-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEliO+G5DWpv2wUAu9opvQ
	(envelope-from <netdev+bounces-289948-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 15:40:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BD458EF34
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 15:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40DD1308F760
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418C72D739B;
	Wed, 20 May 2026 13:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="YOggDdRV"
X-Original-To: netdev@vger.kernel.org
Received: from monticello.secure-endpoints.com (monticello.secure-endpoints.com [208.125.0.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D312D3ECF
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.125.0.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284184; cv=none; b=FkZS9YRKWhjkSNXPvJ/2wFZ15XAg46jQO79JQwFdy2F5P1bDMjnBp6Wz7K6BTJ4ZAjJNvQFhvhM3r1dZGeAR2XNuABfS8ckthy6C4CjdYSVCSndeVmEPMOaA2kS3lkmkEperGgIw21SL/bZHF5pwNaHzkS3FNV72u49pH4KT7Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284184; c=relaxed/simple;
	bh=j/vfDZYEPJpmtTw0/q648MnayfHGdMJthDDhHQzLJTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ct+iTReAkmA9UELngs6YH3HR6oLczMsZ8Qnk5d9mR1mYGEeFfVgGSgLNPnA7E8l8+O6PKsST6oGX5oJrHJs5zE4rDZDgZAKrJhUU8mU5/Y3Q42rzVxh5wdjArhjtTkPDQsWU0h0q/NAMdGne2vpWW/14UaSEezZvYWtcAYjCik8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=auristor.com; dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b=YOggDdRV; arc=none smtp.client-ip=208.125.0.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=auristor.com; s=MDaemon; r=y; l=3734; t=1779284139;
	x=1779888939; i=jaltman@auristor.com; q=dns/txt; h=Message-ID:
	Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	Content-Language:From:Autocrypt:Organization:
	Disposition-Notification-To:In-Reply-To:Content-Type:
	Content-Transfer-Encoding; z=Received:=20from=20[IPV6=3A2603=3A7
	002=3A100=3A8400=3Afc83=3A8701=3Ab9e7=3Aaab8]=20by=20auristor.co
	m=20(IPv6=3A2001=3A470=3A1f07=3Af77=3Affff=3A=3A312)=20(MDaemon=
	20PRO=20v26.0.2)=20=0D=0A=09with=20ESMTPSA=20id=20md500100529290
	5.msg=3B=20Wed,=2020=20May=202026=2009=3A35=3A39=20-0400|Message
	-ID:=20<cd491921-5dbd-48f3-b089-3657b0ba18d8@auristor.com>|Date:
	=20Wed,=2020=20May=202026=2009=3A36=3A04=20-0400|MIME-Version:=2
	01.0|User-Agent:=20Mozilla=20Thunderbird|Subject:=20Re=3A=20[PAT
	CH=20net]=20rxrpc=3A=20Fix=20the=20ACK=20parser=20to=20extract=2
	0the=20SACK=20table=0D=0A=20for=20parsing|To:=20David=20Howells=
	20<dhowells@redhat.com>,=20netdev@vger.kernel.org|Cc:=20Michael=
	20Bommarito=20<michael.bommarito@gmail.com>,=0D=0A=20Marc=20Dion
	ne=20<marc.dionne@auristor.com>,=20Eric=20Dumazet=20<edumazet@go
	ogle.com>,=0D=0A=20"David=20S.=20Miller"=20<davem@davemloft.net>
	,=20Jakub=20Kicinski=20<kuba@kernel.org>,=0D=0A=20Paolo=20Abeni=
	20<pabeni@redhat.com>,=20Simon=20Horman=20<horms@kernel.org>,=0D
	=0A=20linux-afs@lists.infradead.org,=20stable@kernel.org,=0D=0A=
	20linux-kernel@vger.kernel.org|References:=20<488970.1779144259@
	warthog.procyon.org.uk>|Content-Language:=20en-US|From:=20Jeffre
	y=20E=20Altman=20<jaltman@auristor.com>|Autocrypt:=20addr=3Djalt
	man@auristor.com=3B=20keydata=3D=0D=0A=20xsFNBEwLlO0BEACu6yWFkd1
	+qwsGg8ZzgslSkcAKhSegWt5j86DpaRL0W8fxg6YjxwEPvwoH=0D=0A=20BGa/rp
	SdBd1gkmzeYxD3hVZdj75r6nVS9f/mxNQzW+o1sW4vaeSxKgZSQz5RqHmwPDcqQP
	66=0D=0A=20+ZSnjV+G88MKwZ9DIzA9AwpJhNAAlAlj3OvsQVsxd1ipc6C4/U3qj
	HL7Ih22UbPBM71ltIZx=0D=0A=20kqcrAlXPnUTeraJXtfzYbq4mJFJ9JC6/o1NR
	SjsBvRD+ADxlG50+KccZN4SS5xxdGuh1tA9U=0D=0A=20TydYBQB3YtJbq7CYau2
	kIYt/3HnyLYGo1s6Ti6cuAJJ/40iIE1xkqhvMiIz/Q+1ztmksJbLQ=0D=0A=20aC
	tW8kF42nF8MpPdIPTSPr2uGvpRtCjRbh4lgMXgyNUx1wpCEY0X11xce++H8HySmF
	wryE2y=0D=0A=20kkxUQeMUjaaXZDHYUSyQz7riChFiZ9ax9dmX0wUY/A05v0qcu
	alglpk4wJ2kcsGKUEGkLvnV=0D=0A=20wwvya8zifPwKOw5JlGPvzX8t2m7jB2GX
	KzvVAsImqOqnDBTKUXWQQZCW9Rqt7acdE8bQ2vqr=0D=0A=20vP+3Ykf4SrPwcuN
	CDt6QSgjVbhc3hA3hCtE1iW/HhuBAzKiuzJ9era+q9QjTtLPIkQDHRpcC=0D=0A=
	20MMWvK0Y1uQ34Ql1BfKRA4gc8A7CuVUY6+Ga7PuJWd+FSglvmKQARAQABzTZKZW
	ZmcmV5IEFs=0D=0A=20dG1hbiAoQXVyaVN0b3IsIEluYy4pIDxqYWx0bWFuQGF1c
	mlzdG9yLmNvbT7CwXkEEwECACMF=0D=0A=20AlY2YwgCGyMHCwkIBwMCAQYVCAIJ
	CgsEFgIDAQIeAQIXgAAKCRD3enNVkraaBDdzD/0XQUDW=0D=0A=20UWXrpapHdvZ
	aHzPHc3xobRi4PABWfLW1jfMK5Xy4DP/x7x3I2qAqTD6vv/OPFMx8gG6+Xeod=0D
	=0A=20Mj5vE7+7ZRd+J76J4DJH2qoaXX8qnUEABUJHZYDhw2/Ij5AQ6ZsuSwXuUR
	GEMi0vu1ihBbP6=0D=0A=203bt4LRIa+F60ebDvCl9po+UB7TrjQCs+YV1r1YeCS
	v9hEHBly/W0u1OrnNCMWRcq7dmTCbZ0=0D=0A=20R5w6VJ/+QEio+T6paGGMjJmr
	Nw2qUeuK+SxOOxOWS8lgdqzjcK3NsfiERrVbOWM83ZVy0/GN=0D=0A=20vpusjhI
	/3Q8lbV/p+IsJk/v1grkRzgU0frES2ANEPTpC4j2ggPOSMpsz3BZ8wIOg17rIWnK
	+=0D=0A=20gNLQe+XN7kvDwGu0jYhTIZO10jcVsRSrAJGtgBNrYxOjEUhpnaSJDV
	cjapRvRPCQumA13Zkl=0D=0A=20nm4AYjp7L2oOIeOGcKRZwbrGDakksa5iaSIoy
	wpwECWh2l9V0W3SeynBgPtR4qpt4N8yKCcw=0D=0A=20suLCAKfBv9RcL641XZi/
	Fp9btSuTPUm5Lw3SIGr5U+SyezmhzlwsObIF9W624aorriWoXNf3=0D=0A=20GgH
	9ZH0Hkc6aS99pIZhh5USWRO/pS+lv5eNkEdf9LUBGX9b6ZMan0fpoEayqUejtZw3
	O2rgs=0D=0A=20zA+pTSA+/HobvtL6L3XtlPJ1NXlkgM7BTQRMC5TtARAA88hJdp
	gcg2RU/uAWfAL46XZHA59c=0D=0A=20VpPNNly1tPWCSbG6+ONH6nOG/NarmNVxX
	6Mb9YRkEU6wmrZS85inz3otdyz/zlyNSWma8qGN=0D=0A=20UlMbiwFQqfXWVBAP
	GoRC0a0aJrd4IayLuvv1UqEwx7Otp7y5RNHtRv35/kho0Z+UheYVdGm2=0D=0A=2
	0I06xIc+aNKW2LO7R5BNtjpADPIG+NSdsVIeamhAWPvLrwbf6mUb//eA9pF0w0Qi
	xLVrH/cCo=0D=0A=20z+S27gCGJvY6zF22NgdhnkIqNz8E/LKt6S36ZI9Mw/ixpQ
	TozqRmdNzVQNgTHUZClbJj4iq1=0D=0A=20EPHB7XqpxOv+awrxSxq2jt8GFD0rU
	+sAuzW+F7cBoIw434/IrxKYwcPHpHLEVQ1tLP7d3ZpZ=0D=0A=20R30p3oqoliGi
	LsWvHHxyXjuMBF4XJ6MRXmD65/qOhuo2DKduHMNlmxzgSzvWgXZeNJq+OcS8=0D=
	0A=20jQZDt2Na2pMKjWytau7xQu2ndm0FwS48ngMrDYRQMxzL1NfnBnT9BCwjiU+
	/6NBSwcNKIqye=0D=0A=20a9IpTwsVfkF4/iui7xD9+LtzqeUkBAe7q5jEJmJMZh
	Afh7usZGT8TGxXegCaF4Jwz2nxS4Fv=0D=0A=207VRza/yUAOJlc0daR11TPeiUN
	CQWY7PpL1AXO9vaSyjFuOzTnU8vzXvI9fGoxIxKGRQpKMU8=0D=0A=20PROIFw0A
	EQEAAcLBXwQYAQIACQUCTAuU7QIbDAAKCRD3enNVkraaBIxXD/4xlaBwW2TLFfMv
	=0D=0A=20lcY/2XDSm6NO4JaJG2Nzp35xaaBVwMVzWvI+GgTgKNSFot9f4jiLBNQ
	dnq3UKoEThR2ORKVL=0D=0A=200ZJS1QYR7yyrOo0MteDSy8ofU1FJ6xu4ND3ekO
	jP20BTrihDpqUdahir2uaRfMkwM+0imOlc=0D=0A=20utGMhJNF/LAjrhoDp9SeD
	MYBXZ1wfrbrEo/EEu0PbkGyzqPyEPqwN1iSJkcAnjuIA0rTf1jQ=0D=0A=20tJAa
	Dov7yHsSRwUM+qTGsjOGQAN3wtYwjPpw7hI01sE+x0uq0pVeo4qeWTZ2TE4Vtp8F
	KXFA=0D=0A=20kqnP878q+kNk9Ve+DRs8UlRfa9Lgf5ETjXOTVGaT/UGxi9B4oo8
	k0lzvM/A1txexL/lLw8AU=0D=0A=20LhUeGtyS6D2X9vFi6azna+o918R9BV86uX
	PiDOf1nMwqKchNCxmgH9vd0aQm8TKCrWAW4kU1=0D=0A=20Ig6aMNuZiWloVZfKr
	mWizbgeGKE9rhNPNqxkqBaA4lrJ8L6bdKbhAOe3NQjO2vUAXB53Jphl=0D=0A=20
	F74GwEsh+85i9/yIbvwJVcsFYhdZz7fCAUOcnFkGnyrwIgkizQ3xXShPW8mqkgUk
	4kYMnucC=0D=0A=204kG/E7pI/4lke5X5X9vroXRHB7tkpAgT46SqSM/XTwCaseX
	G9orDgz3duRTUp6K0++S/qsqT=0D=0A=20akGVmjD5917A1HqWfMmiKA=3D=3D|O
	rganization:=20AuriStor,=20Inc.|Disposition-Notification-To:=20J
	effrey=20E=20Altman=20<jaltman@auristor.com>|In-Reply-To:=20<488
	970.1779144259@warthog.procyon.org.uk>|Content-Type:=20text/plai
	n=3B=20charset=3DUTF-8=3B=20format=3Dflowed|Content-Transfer-Enc
	oding:=207bit; bh=GBoyPQ5P5mLeedfl4knsgBHSSzmLEwY1p0kwqE4+Xv0=;
	b=YOggDdRVZCX1MlCgVJZJ3aA3DckRieCAqo5ar5ffhFuOz/hTcS4tRU7oqhn8wN
	KTUjgG3gJZ7m1FlInfJxbopSSW29Y71KbzghNYADHY0mpOIRrutfeDlCpMUDv8Nc
	1KOth/te2j+giKNCy/EKbnZcc4m16GBeBxsFx3vNv3GEI=
X-MDAV-Result: clean
X-MDAV-Processed: monticello.secure-endpoints.com, Wed, 20 May 2026 09:35:39 -0400
Received: from [IPV6:2603:7002:100:8400:fc83:8701:b9e7:aab8] by auristor.com (IPv6:2001:470:1f07:f77:ffff::312) (MDaemon PRO v26.0.2) 
	with ESMTPSA id md5001005292905.msg; Wed, 20 May 2026 09:35:39 -0400
X-Spam-Processed: monticello.secure-endpoints.com, Wed, 20 May 2026 09:35:39 -0400
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2603:7002:100:8400:fc83:8701:b9e7:aab8
X-MDHelo: [IPV6:2603:7002:100:8400:fc83:8701:b9e7:aab8]
X-MDArrival-Date: Wed, 20 May 2026 09:35:39 -0400
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=1600c30037=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: netdev@vger.kernel.org
Message-ID: <cd491921-5dbd-48f3-b089-3657b0ba18d8@auristor.com>
Date: Wed, 20 May 2026 09:36:04 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] rxrpc: Fix the ACK parser to extract the SACK table
 for parsing
To: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
 Marc Dionne <marc.dionne@auristor.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-afs@lists.infradead.org, stable@kernel.org,
 linux-kernel@vger.kernel.org
References: <488970.1779144259@warthog.procyon.org.uk>
Content-Language: en-US
From: Jeffrey E Altman <jaltman@auristor.com>
Autocrypt: addr=jaltman@auristor.com; keydata=
 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
 akGVmjD5917A1HqWfMmiKA==
Organization: AuriStor, Inc.
Disposition-Notification-To: Jeffrey E Altman <jaltman@auristor.com>
In-Reply-To: <488970.1779144259@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDCFSigsAdded: auristor.com
X-Spamd-Result: default: False [1.34 / 15.00];
	HEADER_FORGED_MDN(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[auristor.com,quarantine];
	R_DKIM_ALLOW(-0.20)[auristor.com:s=MDaemon];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289948-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_X_AS(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,auristor.com,google.com,davemloft.net,kernel.org,redhat.com,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaltman@auristor.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[auristor.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[auristor.com:email,auristor.com:mid,auristor.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,infradead.org:email,davemloft.net:email]
X-Rspamd-Queue-Id: 70BD458EF34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/18/2026 6:44 PM, David Howells wrote:
>      
> Fix modification of the received skbuff in rxrpc_input_soft_acks() and a
> potential incorrect access of the buffer in a fragmented UDP packet (the
> packet would probably have to be deliberately pre-generated as fragmented)
> when AF_RXRPC tries to extract the contents of the SACK table by copying
> out the contents of the SACK table into a buffer before attempting to parse
> it.
>
> AF_RXRPC assumes that it can just call skb_condense() and then validly
> access the SACK table from skb->data and that it will be a flat buffer -
> but skb_condense() can silently fail to do anything under some
> circumstances.
>
> Note that whilst rxrpc_input_soft_acks() should be able to parse extended
> ACKs, the rest of AF_RXRPC doesn't currently support that.
>
> Further, there's then no need to call skb_condense() in rxrpc_input_ack(),
> so don't.
>
> Fixes: d57a3a151660 ("rxrpc: Save last ACK's SACK table rather than marking txbufs")
> Reported-by: Michael Bommarito <michael.bommarito@gmail.com>
> Link: https://lore.kernel.org/r/20260513180907.2061972-1-michael.bommarito@gmail.com
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: Eric Dumazet <edumazet@google.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Simon Horman <horms@kernel.org>
> cc: linux-afs@lists.infradead.org
> cc: netdev@vger.kernel.org
> cc: stable@kernel.org
> ---
>   input.c |   22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
> index 24aceb183c2c..0c15ebf19eae 100644
> --- a/net/rxrpc/input.c
> +++ b/net/rxrpc/input.c
> @@ -963,21 +963,34 @@ static void rxrpc_input_soft_acks(struct rxrpc_call *call,
>   	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
>   	struct rxrpc_txqueue *tq = call->tx_queue;
>   	unsigned long extracted = ~0UL;
> -	unsigned int nr = 0;
> +	unsigned int nr = 0, nsack;
>   	rxrpc_seq_t seq = call->acks_hard_ack + 1;
>   	rxrpc_seq_t lowest_nak = seq + sp->ack.nr_acks;
> -	u8 *acks = skb->data + sizeof(struct rxrpc_wire_header) + sizeof(struct rxrpc_ackpacket);
> +	u8 sack[256] __aligned(sizeof(unsigned long));
> +	u8 *acks = sack;
>   
>   	_enter("%x,%x,%u", tq->qbase, seq, sp->ack.nr_acks);
>   
>   	while (after(seq, tq->qbase + RXRPC_NR_TXQUEUE - 1))
>   		tq = tq->next;
>   
> +	/* Extract an individual SACK table.  A normal SACK table is up to 255
> +	 * bytes with 1 ACK flag per byte, but an extended SACK table can be up
> +	 * to 256 bytes with up to 8 ACK/NACK flags per byte.  The ACK flags go
> +	 * across all bit 0's then all bit 1's, then all bit 2's, ...
> +	 */
> +	memset(sack, 0, sizeof(sack));
> +	nsack = umin(sp->ack.nr_acks, 256);
> +	if (skb_copy_bits(skb,
> +			  sizeof(struct rxrpc_wire_header) + sizeof(struct rxrpc_ackpacket),
> +			  sack, nsack) < 0)
> +		return;
> +
>   	for (unsigned int i = 0; i < sp->ack.nr_acks; i++) {
>   		/* Decant ACKs until we hit a txqueue boundary. */
>   		shiftr_adv_rotr(acks, extracted);
>   		if (i == 256) {
> -			acks -= i;
> +			acks = sack;
>   			i = 0;
>   		}
>   		seq++;
> @@ -1117,9 +1130,6 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
>   	    skb_copy_bits(skb, ioffset, &trailer, sizeof(trailer)) < 0)
>   		return rxrpc_proto_abort(call, 0, rxrpc_badmsg_short_ack_trailer);
>   
> -	if (nr_acks > 0)
> -		skb_condense(skb);
> -
>   	call->acks_latest_ts = ktime_get_real();
>   	call->acks_hard_ack = hard_ack;
>   	call->acks_prev_seq = prev_pkt;
>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>




