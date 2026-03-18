Return-Path: <netdev+bounces-268830-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6K9OChvtuWm3PgIAu9opvQ
	(envelope-from <netdev+bounces-268830-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 01:08:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC202B484A
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 01:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB42F30C76DF
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 00:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898ED1E505;
	Wed, 18 Mar 2026 00:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoikiAEb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5480DD27E
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 00:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773792503; cv=none; b=UrWscIu/n3BmDiFqgcertcb5aQ3xkJ/gnUGTP3yMDNFtQ1kYqKFe3vSvcJbzAOXC9tDLMYgVLom0AqcCwtmWLsExBsX019fpfHz4VdmMWdGST3mOF63RBHmGOREiY1KATQFi7n8hLb9b3JtOnTMwY615IDAdexQU2NRc7F+dzqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773792503; c=relaxed/simple;
	bh=cb8vE5HSSq56kcm56PlKyEh4gwh0lYtwbgbWt/bAoqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avN85+EB1XoC0tcsQVNSVIMFsFZKKXPMQMQsw91UY8s2wPqYP4FtxdKGjYpjO2kuRfdFAUFieRF/gb032l3sJz9JGv4wPp2N/WjNl7wM/P8HR5u8RtSAGDmBkLJQAaSvY4Y3U2cX1Ga53eJPI75NLIvQPEAwTO81uHPF9NXSVsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoikiAEb; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-128ef6c4a41so3089550c88.1
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 17:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773792501; x=1774397301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=66d1uFpzzYCPdrNc8SA1GRs22SJbjq+tbh3FLYNMt+0=;
        b=VoikiAEbYz7YDzEx9ZurrTlvtBsB5G3PggbpGOo2tVhI1Zls437fOikSRxq5+nJRW0
         rkB/xgnpOo2N7uBVffghrmR7bBLZPXsi0pk1eXUUyrkGA58zmwk8R4Be1r8KN0t7gWjP
         eDBhDJWfGzFcx7ck4XTK8pvryRpsGracfmKPxDUfA15WPu3N1ol1I132/BqI73QrTcvd
         ZTmLQAjCF0pGpsA7HM4tuQ0NMQGSmg/+Ti2IRbOM66rodehJYfhlindkb0jExiPhuEBH
         LxerTl0R5d8fpitcjfyDnZWuaN1xBe/V5u0TUk8DH4podPB5zMk4qYE4df9Rd7lGyvGP
         O3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773792501; x=1774397301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66d1uFpzzYCPdrNc8SA1GRs22SJbjq+tbh3FLYNMt+0=;
        b=jls1E5l1CoLvbbBBzq7GIccDwe325Ny78sBi6ZVOgfMwbQlDFXXKGgmiqc86fzM9WW
         NSJEU4O9oURIXhF/BPF744AgTlR88iPqL1ZxO9vC+7mvdH3SXdbvuZuvfFuEriDwF3/g
         6OO7BdekUwc8uFDUeYBJ7qzWYs7DDpTPDHcUiaAmEz52Vultg/A0QY49oeN4XUC3ZZJC
         zl9IEv1KkmTarv3qgBoSugP1QA+OyGT/rkfSnGIEFZV7fxZgNz5LBf3cV1jy0T0xiBZL
         Znv7Nj4Ci3oVvGtPPhDQbt4cXbh00+b8lwyLZY2Br2AjQYh5A+kPbYrsFW3VSe7dpW12
         /6iw==
X-Forwarded-Encrypted: i=1; AJvYcCU7GVucAJD3yqx8lh1kiue5h0jVX5KGOcX3HYYywYxLVVGjPx9pcVrrOwda6V5QAfeWdD0Cn7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx4sQg7tDGtOSB50qJ3QF4IQpMXgBl65UyUAn96SlsYI1vA/qQ
	SGVVzzMEw1Kf6/bW8ORvZG8Ea+HmirdLv4y7I26jQPJ+QDd6HYr+Iz0=
X-Gm-Gg: ATEYQzzxUPigN3msUP+gG+3AvPA3pnB0B7YrcqN1YBSOuWnsa+gufrpORfvIg9LQZ+k
	DODmdabABYtFh0OmXuxS7HGBrpZOci9IpOnLGM5WG8zyOfykhfHj9L33l8pOza82/lp054j4q3d
	5QpEibihgB+xE4kJpy3e9yJE6EL7OtSwe6cJgGtcpUM3TJ/WDiDSOPoLjeXlLK++c6ygl2Kayis
	KMPRk0pP/18Jwuz9TvyEvxIQbLbX+HbZ3c7YDDfZLNiRlC21iTAQJzIYr0gHpPGLnr0lV5fL6IP
	8hUO4YOvrV6+Voi/Glfh7W+TLOml2DquUWAyxobcz2u8TSKz3qoOPmhSafV5/m8cC5w9exz5KOi
	GUo2fy1VHcU8F0ncbA/02vjRZCCT513tXsjEjuaH65xU11jelvuQZq8sm4mOAK5+RR0334dXVQJ
	dzaQYssgxImIFEi5G0ZuMiXU+A0agqWe1JGqBPuZyZiObt1ZuhgOdjUWopIDsrhW0z9lAiEJxWX
	J8IMh2KxZmiE6/Mpw==
X-Received: by 2002:a05:7022:6a5:b0:128:d471:8c1 with SMTP id a92af1059eb24-1299ba3e555mr676234c88.17.1773792501230;
        Tue, 17 Mar 2026 17:08:21 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-129b4127b7esm2264454c88.9.2026.03.17.17.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 17:08:20 -0700 (PDT)
Date: Tue, 17 Mar 2026 17:08:20 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>, Wei Wang <weibunny@fb.com>,
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 5/6] selftests: drv-net: add netkit devmem RX
 test
Message-ID: <abns9COj7WagFtZ8@mini-arch>
References: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-0-b53c8cd72b23@meta.com>
 <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-5-b53c8cd72b23@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-5-b53c8cd72b23@meta.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268830-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: 8AC202B484A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/16, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Add tests for devmem RX over a netkit device with a leased queue. This
> is the same as the other devmem RX test except for ncdevmem executes in
> a namespace, binds to a netkit, and skips the ethtool NIC configuration
> steps (relying on the test runner for that setup).
> 
> The RX path is setup as the following:
> 
>  RX Path
>  -------
> 
>  Remote            Physical NIC          Netkit Host        Netkit Guest (netns)
>    |                    |                     |                    |
>    |--- TCP send ------>|                     |                    |
>                         |-------------------->|                    |
>                       dmabuf                  |--- BPF redirect -->|
> 

Is it too messy to parametrize the existing test to run both with and
without the namespaces? Feels like should be somewhat doable in python?

