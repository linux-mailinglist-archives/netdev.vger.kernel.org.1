Return-Path: <netdev+bounces-302552-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BxcAEptBQmps2wkAu9opvQ
	(envelope-from <netdev+bounces-302552-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:57:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C031C6D888B
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:57:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Ycd7vFhz;
	dkim=pass header.d=redhat.com header.s=google header.b=e3uKCDuN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302552-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302552-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E277330506B8
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 09:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953903B7777;
	Mon, 29 Jun 2026 09:50:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A0336CDFD
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 09:50:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726649; cv=none; b=HtEnZM1d2G1xvSnH1F1yf0JndzyveRnIufmkmeCJD+bA72e1wOLPIq1fl1QvRBbiTbPPcA39D4lW99UsanBYIAI4SC9upVhhqsOsg0fls25OdO3MDYjmts130KjDLq8zAR7OMtufa+uC/rfmFA4nNYOWGnMZB8d/DF74l6OhJcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726649; c=relaxed/simple;
	bh=ACyWfY2kPQJljL8+3rbVUnFnxv3dYfoIVpzokml3Mws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PmXmKO0dZp+W+pm4mGihrstoVFoY1T/D6Tm7QCAVdQPv2PphlZea7SkDfD9nypGHQlSbUJgqUDr0cB4OUK2MGCwrs76mSNqK2APWNP2l2mZtmve3fSyOEyo+PsNTRkL+Dr2mmCqZU8Nef37yZviiEP0MzFWIvS53TbwD9/WiCKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ycd7vFhz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=e3uKCDuN; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782726647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2/M9+nQY4UUFkdH/+tXgorDJKcJ/lXoZMGO1FuRWX8k=;
	b=Ycd7vFhzBBboEHac7lbM4ruBjPWcuUIKIOj94tc+eMygPOEqSuwXb2dwoQZPhFwyNz8fl6
	PfCVhTDqsgFaxYljf0L3rnw3d7uTUpRRdMfSOLGO6f1DPTGFQAErDdC/fqDOZ+eD1VEoo3
	c1rHAu6FfKx6hcFmcDu1TgSIgdx3jJA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-Btd93jqVNSGP1v5OXUAR8g-1; Mon, 29 Jun 2026 05:50:43 -0400
X-MC-Unique: Btd93jqVNSGP1v5OXUAR8g-1
X-Mimecast-MFC-AGG-ID: Btd93jqVNSGP1v5OXUAR8g_1782726642
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-474170b59dfso255873f8f.3
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 02:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782726642; x=1783331442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2/M9+nQY4UUFkdH/+tXgorDJKcJ/lXoZMGO1FuRWX8k=;
        b=e3uKCDuNAWpe/tvRHu1ckwAq7bpB0M9Bn6cMOnQh2aN8xoytIZhgCtlQodZ0quzqKi
         yJazW3X0cn9h0ncWzWlAdcbooCyPt4lfkdClIO4PBzk8q42Qf7MWQR4dtsfL91XHps9y
         sGRIanqAPwGKngaWcpUpCNyGksb59g6fmfDW3YoHIeXPW6PUwfTHCco2hcFThkOmutNf
         kKpQ/Jxd+k5SU2yipmGpjisXxRPr86XG/sfBQftXuWeDl5RD/5X0fPNnIzb6gF1kK9QZ
         uCe/Zlg98JALza1I5p8BNi1xWEguY++IyW5LuvCu1PPKoz/TEpaZqyG04fZONaBAPW69
         FT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782726642; x=1783331442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/M9+nQY4UUFkdH/+tXgorDJKcJ/lXoZMGO1FuRWX8k=;
        b=LIsLj7mgo2S6rpVbx3oHWW7FP2Ja6igdXCU1BresLSn96P8hvbcYOMl9K0T3g8YLiP
         l4BOnfXSd8e1E+YP+2EAKMeCpJKos0Xqsfu1aTlIx4+1gxCaAlSTOZ/1hAwajjRErK84
         pS2Hbq7nLutA20Y14B3igrYFVukoXBRTXwD+1+s/sPCN1fzbWhOmykD9wjTF4V6LuZav
         nZ7agGquBJElRSoDo5Z9rw5NGY+TzEAUiqyrebp3TanNEbLgfeNRuzo6CQLq7UfRs5M5
         FUvUFDGB4Gb3vOsqio5JD3040W+fZGlSvzjA9w7bbOld/pZsO+m4ZaFr2U1jSvJFmtB4
         t9wQ==
X-Forwarded-Encrypted: i=1; AHgh+RpGHj6KvZ66+or1zqLZw6yNNjWN5aSpjx3V/2Y8LbUS3TS8G2m+tQfvT6AO5F1DwIdMQp2cRoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCkjSqecs2+rFDVoLovMGqNXmYEekFeuwlDajWRWE4SGuuUlrP
	GRUktAtF4uF3u7MIZJHUQPt9Ki5MXyIWX6H76kypzlkOze0CEzBH6bsilEPeKjt7rAucYeUDyZG
	BMx1oVT164heDdhMqbWI1LzAKL7qXqyd6/QGt9zLKyt2yneJi3R+DGA2vGQ==
X-Gm-Gg: AfdE7cmcQsFd+X+XaVYdxwQgZipt1BI5ZxUwEJ0tZYyzjtWwAO788Me6LkyDZD/LVfU
	dVjxmY5nh+E5Cm6oiHzJJ291TD4W4bNSKEdGZDVcldqeYHmkxenIcn0Ch+i15OHANn6LhRiUHHi
	6VrJBZdWzlobIEzuKJefTZNsAd9055znA8U+N+aUq+GDv0g+NZJ4YXztet/neiTz31LdeaZKj49
	srtoFo1mygpEugUxKqI2qGXS1SYQXg5Wo/h0cuUaRSfZi2L8dbV0aLbqzOnFDBUBCU4Y+PgwC81
	puRgL1beBlc5mFijFluL+L1XuhZQ4tuCXlay50N+7+z9Sg0yxVbpU0FeZ1cZCLO/RwocGuEZJsi
	cL5XvYxN7YeaEBfP1RZA0EYLZhq6SvGnjUPJ44C1uFR6aMNs9wTFdB1eEC/NYrkZFinWKQmDYrU
	H0A3KgNJTI0w==
X-Received: by 2002:a05:6000:29db:b0:45d:3aa3:7f76 with SMTP id ffacd0b85a97d-46dc14cbf6emr18737569f8f.33.1782726642098;
        Mon, 29 Jun 2026 02:50:42 -0700 (PDT)
X-Received: by 2002:a05:6000:29db:b0:45d:3aa3:7f76 with SMTP id ffacd0b85a97d-46dc14cbf6emr18737529f8f.33.1782726641633;
        Mon, 29 Jun 2026 02:50:41 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46f9db29a94sm27551970f8f.22.2026.06.29.02.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 02:50:40 -0700 (PDT)
Message-ID: <3ad5bba8-18b9-48a6-94e0-99d958f23984@redhat.com>
Date: Mon, 29 Jun 2026 11:50:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mptcp: only honor zero-length DATA_FIN when a mapping is
 present
To: Michael Bommarito <michael.bommarito@gmail.com>,
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, mptcp@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260617215725.1116295-1-michael.bommarito@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260617215725.1116295-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302552-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:matttbe@kernel.org,m:martineau@kernel.org,m:geliang@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:mptcp@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C031C6D888B

On 6/17/26 11:57 PM, Michael Bommarito wrote:
> mptcp_get_options() initializes only the status group of struct
> mptcp_options_received; data_seq, subflow_seq and data_len are set by
> mptcp_parse_option() only inside the DSS mapping block, which runs when
> the DSS M (mapping present) bit is set.
> 
> A peer can send a DSS option with DATA_FIN set but the mapping bit clear.
> The parser then sets mp_opt.data_fin while leaving data_len and data_seq
> uninitialized, and for a zero-length segment mptcp_incoming_options()
> reads them; KMSAN reports an uninit-value in mptcp_incoming_options().
> 
> Impact: a remote peer that has completed the MPTCP handshake makes
> mptcp_incoming_options() read uninitialized data_len and data_seq (KMSAN
> uninit-value) by sending a DSS option with DATA_FIN set and the mapping
> bit clear.
> 
> A DATA_FIN is always sent with a mapping (mptcp_write_data_fin()), so
> gating this path on the mapping bit drops only the malformed no-map case
> and leaves valid DATA_FIN handling unchanged.
> 
> Fixes: 43b54c6ee382 ("mptcp: Use full MPTCP-level disconnect state machine")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>

Isn't this fixed by commit 5e939544f9d2 ("mptcp: fix uninit-value in
mptcp_established_options") ?

/P


