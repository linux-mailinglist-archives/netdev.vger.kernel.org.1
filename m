Return-Path: <netdev+bounces-253962-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAYZBF/7eGlfuQEAu9opvQ
	(envelope-from <netdev+bounces-253962-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:52:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5DA98A96
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDC35300AEE7
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 17:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D782FFFB7;
	Tue, 27 Jan 2026 17:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OZE0yTGB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8060C320A34
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 17:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536347; cv=pass; b=QcHpD09+NjFevrCMRX9Z1HQyCtxzobWS/5uc/+TBcdAzFyOgfmDDToIIIY4eAu8lGemLQDoXNXq7q4VfXfkKGPXpxxEgFmQXtj3UGUFVu2hCwIcH0saVRXla6bC7fosrP/Xg3b9sfa8kj/bGyrxfDEsN37Z4zHX7OaPsbMo+Op0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536347; c=relaxed/simple;
	bh=RL/HGZ7AUNdxSov+yggntAAQqajmYC8nRg6O8zAOw4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mny/9zik4FP/IdrCZ/mymRaSOiMXf09PpNem4cSBAJp6PI5knW0xV9tdaakPGKLVrfuNIxkPZQVHdnhiQfEwYLawkivkXaHDB7+f/FNLBXPX4LFt5VCuhrLiZlDymISEZBybVd0kPXk8WPYd10qRMEHTlUlAFZMB7EGsWZl51dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=OZE0yTGB; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8870ac4c4eso658565966b.2
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 09:52:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769536344; cv=none;
        d=google.com; s=arc-20240605;
        b=QQuCkbjkg8VH1i7UbNOaPI9NoKl0US+HVqcsjNATkSfFnAx+PHl59Am5ypv7pD9yfR
         HWG+YM02xWAb3S3TdAh8PVUu7dne+IusCvTtq4/S9JTmhZXgrqt3qCNEehjVKL1bvFat
         oZKBDXb1FbBRptcCLgTpU+gg1olHAVyzJxEcnQ2BK1ubmfi91ncgz90JOS9aaIJRvTrI
         i+ctBpMXb6gYXrvuKXi4VDnBBhA0sMDDkZV+43CIijdIOYpei7EYgmYteqvKflSN1ngw
         mFF5+Xfvppq9inQh99xPPivE9CTVAVd02VeKJ78LVX8DfLLFCLUl2ZxiwVVK/v0o3OOA
         QG+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RL/HGZ7AUNdxSov+yggntAAQqajmYC8nRg6O8zAOw4c=;
        fh=kKsuARn9M/3LH9PQVmHs2gAh78mbUvBPgDQX2GqedBk=;
        b=QvmMasRxQXeXB6nfeOCyV9hjQwrz+Zauc6TqNJBg9SdfeSbiuXZghTa2wKPVomYgor
         pb1x6zhW7ByQ88YPp9aJdY8/G3Y28Yhlz9vdJrIhW5cCQMktFFPSTgm6mxWgDEI1NGsv
         Xuiu+xzpYxxV2Y8u3dEbAUTALlKkUDp8i2YrTSc48tL4UqLJjHe/VfX2xIvOMeMCBQ8M
         OrshJjoy7pW/7p4CtZnGVqjUsa6MWFLFn/qYtUJKAjiVt8Kn8aVVKaQESDh7EY4VC4D7
         lUtyQ6hC07d7nd4DH9lPvD0MuSmEtRxeHgaQhfnOo97vazci4bJ9QWCxmVAgq0P3Ja3G
         XNfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1769536344; x=1770141144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RL/HGZ7AUNdxSov+yggntAAQqajmYC8nRg6O8zAOw4c=;
        b=OZE0yTGBT6z73u8rZ2GOTmGQYJoP4zVprvCcL8Xhs3Xi16hcfk26/BIDbFhmNsD2fS
         6zlZbvN8syE1ltHsybgIZbiibINCR8GZxECSZcPyQxn2WLa9HapP6Uw6xbtDFhZ7jTGJ
         4SNpugPCNbFCkN55axFOuo1p9ruKWKY4l8ajFoVSAuGTLmdAdiMNDKbkJ4NJMSUikVUa
         0S6TpVis6mj3OuIdrCPFtCwJVUCAKZfdF/VsQBVfQy8lb1c7vUmEktMT2KOFty2BOQ0J
         E01bXNkIvj8ajilRTXUX5PTktG4hASk5WZed2KIl1rEPDEGwaQS7Xwv4dKmZJ4HHZuHZ
         eFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769536344; x=1770141144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RL/HGZ7AUNdxSov+yggntAAQqajmYC8nRg6O8zAOw4c=;
        b=YfZDY4e2UsxVUE2kRWSsJkclbMoQmZmecYOXJOE6ar1n7WpgM2Ynu+AQVborgTP7wf
         oTGYkvU0nMvGcBikOCT/kmHo8+G9ehsbXCesMvUkzyFuVjL72v1X76es25fitv6S6SxI
         NpeJD6Hdu4QNCaAZpRljb4KYe70S+HibJ1+ecUmLpi/2WuieWdQIHxa5NxXGmmQoJ7M/
         TVXwjZFhoG6cqFJjq96GJqyRI+OhBH/PY63x3xtZfp7RFGqHXYJHBoeZlA4gaVt7SNeN
         XCWJJ7wy7l1+keOOd12Mqc1iV/WhmjT0qYCA1eWpiUJ38mABgYDMXD4TXAF6Dh/jiX6B
         0YVA==
X-Forwarded-Encrypted: i=1; AJvYcCVAmd61gl7uYsVjS+GMAMM2IdQdS1VSf2KlXH3JaN5KxK2I1K4JooKwyuQie4d5XCkUkPWfHLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXoHx0T1rWoTg/0BfFIgj1X44bfnMPrnroOu40ePzg3KRK1nq5
	06unhtyzZl05wTNEjTZJnhCcKqbnQcUwnRuVIpWShDnRNJQLJHu3ivznRpxAqzMP+3lCUTxGbqA
	WzDY6+S9yLon4ujoOgq3Y/hKPhi/nlF4SvWU2dc2zZw==
X-Gm-Gg: AZuq6aJhORIMzAzIBeIZnX1wjqlv+Ie1LOGwF3AhHQg/CbuF6Hkzy+4ldPyO30HLG28
	2NBAvVHskKt06nkSZ+tbncvc/TdmaRrOjVdpiVtqnJTytTq1E8q9io2QOc1sAfR2wWpe0eOU5Pm
	dHqh19FIVFidgbq1gQVVi2aYVtUAz6O3yQbHhtqUesde9UJQgsjwqMb0q+X70EZE5XH8P7zen9r
	wr1AFYmJ4W8Vo6B4AzetRMsnYn2qS2cVA/l75z4JywKntxaaxKNKFu/eKk9KHn2K+5811P6b8VL
	FJ87A+/HaoI=
X-Received: by 2002:a17:907:3f0c:b0:b76:49ae:6ee6 with SMTP id
 a640c23a62f3a-b8dab1a3ff8mr209591366b.15.1769536343903; Tue, 27 Jan 2026
 09:52:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201233853.15579-1-jbrandeb@kernel.org> <IA3PR11MB8986697A94FB36E893C7E87FE5A7A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <d6dcd835-7564-481a-a854-25b187893e6c@cloudflare.com> <IA3PR11MB898654344D883B1CC06A7636E5A7A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <a2abd596-f8fb-4c2b-9181-7c2c9f0b9936@cloudflare.com> <17575378-0c3a-481d-ae8f-e0136509defb@intel.com>
In-Reply-To: <17575378-0c3a-481d-ae8f-e0136509defb@intel.com>
From: Jesse Brandeburg <jbrandeburg@cloudflare.com>
Date: Tue, 27 Jan 2026 09:52:13 -0800
X-Gm-Features: AZwV_QjtxLVcpC7ROKzH-eaEz9ZG1GFQ9cIgDBqaeFV_thRRiLXMknF6DUViIRU
Message-ID: <CAB1XECXEQHuU29BaX4j0iMMsz_2SKkG_uV=4Py9FYVxfT0zeuQ@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH net v1] ice: stop counting UDP csum
 mismatch as rx_errors
To: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
Cc: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Jacob Keller <jacob.e.keller@intel.com>, 
	Jesse Brandeburg <jbrandeb@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	IWL <intel-wired-lan@lists.osuosl.org>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253962-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jbrandeburg@cloudflare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,cloudflare.com:dkim]
X-Rspamd-Queue-Id: 6F5DA98A96
X-Rspamd-Action: no action

On Mon, Dec 8, 2025 at 2:21=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.c=
om> wrote:
> Right. I agree with Jesse's proposed change. We still keep the stat for
> the ethtool but we don't report it as a full error to the standard
> statistics. This matches other drivers from our own products and other
> vendors.

Hi Tony, can I please get an update on the status of this patch? it's
been two months for a 1 liner "net" fix.

