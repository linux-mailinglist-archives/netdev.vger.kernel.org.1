Return-Path: <netdev+bounces-253604-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDs8H//kd2k9mQEAu9opvQ
	(envelope-from <netdev+bounces-253604-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 23:04:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EFD8DCF4
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 23:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 885CC30078A8
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 22:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689F92FFF82;
	Mon, 26 Jan 2026 22:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeB0gI+/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFC12FF65F
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 22:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769465085; cv=pass; b=bsuXRK5My/gUzokgMGTRqg+/RfGY4r4fTDy+6Vw1XsTmpSbm6EEnGKclP/Qy+UxF3vliT5tJIsfWwVU6+U/e7vu25sJF5wfKHxDeY7DRCDrqYsKZ8151CWpiWAEOme+6jT8kY+F6RAn9IA4MrGjSy/sbHrDbJW/KsJogyasUpbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769465085; c=relaxed/simple;
	bh=7YG21uS5Q3aTxJoxgOLQVMsuQQQPt4JTzGp95ovsFsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M37ydwAEbrZx0277v6NBrjUj/kBYgk7qAE1pHBnK4tm+AIKBsnMlZGYNMOxn2iaEpV1XlelrQG4U+zHlBhwf3LJ+DKgdQyNlYVaCkBEZrN2tN557IP1k+PtLMYBI56g6C8dKiWAXNEtG9EVsgollEE6+5hGqdyANSjJyYhxP5aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeB0gI+/; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78fdb90b670so43972897b3.2
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 14:04:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769465083; cv=none;
        d=google.com; s=arc-20240605;
        b=Kq5ORtrvvV6InZLexN4clewZa+KmylcY3KxXVYSSxrrjTsgtZbBLbVZM56SA9zgo3j
         /2KfWgKzE90Cj8HNxHdtZ2KmUQO9FfmdR7LNii3HM91slEYr2pJ4xMAo3ATqzQ6WvV+n
         tPC9Fckg8zzToNBkX+33enDqh857k6L6zKfLKdDeKbh/gFbvIyKbzkEme/EhQLGNea4k
         kayEnJr2ku7g1gJ6Q6DYkasMB5IxlYx13bLIktuigTOee2x4dcnxI3wQ36z2EDFkrVSO
         O+YGQw1cvv422xXhQS/RviLZqB1sA0ZD5HRc7jgAMuAH7zji4eGes54banB1Q2fqngkn
         EhFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7YG21uS5Q3aTxJoxgOLQVMsuQQQPt4JTzGp95ovsFsE=;
        fh=Tjx/Yya/mDX9f0Fol8l0ih+p/Z5Xmb1fL+QreqMQ/GA=;
        b=QWG3XmqSTcZ2CsnYTokFDs+1NmNRKsi5D/SNfSYiBI7735NffwWgiGdNB3gQtnDigf
         LVY8sRLgbU2QL9RYqurzSSYeLOwJpXwDjwsNYMZ0/jR4yH4oO0LC3a70r2TyVwzly0K6
         zO2BOGbiep++Zhsprl/aHrosraUh85qrq4nj3HGa5texeKKmXAkndCWHrOOy4jloTD1g
         iFgl+DaY2S4Ge1geFG4FveiAevsQazot0MCC9nwnWGpZQEcz92Pv3XMZfvgMlutk+tNH
         cXRt5D2OrsQMJsbEnBkizChaR//SVESUEiAI/DHj6tjbwHD9xnrnyxY918D6PMwyBvMW
         SsTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769465083; x=1770069883; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7YG21uS5Q3aTxJoxgOLQVMsuQQQPt4JTzGp95ovsFsE=;
        b=SeB0gI+/2Wx2lV50hnRI/YgaHZvHsKB28MOlNnzpAI5vdgs7gZiN4AB425/Hhclvjz
         bLhN3ZNejxhIoqyKoVyviDlSJkhUF+379Ghqa0cmYteBzLqorjm8Zw+JZREQGziTH58P
         WmKXqRte247yz/AFC3xrDqN70GtoTNspJXrpHCkvw11dkRPusn47aQOkiIBApUDTAAjZ
         hgzkqsZl0MRTh/jWLLLytrleb4wtwlidiJMi4HecXnS32JShIY8mGKaCC+zBPTutZi0i
         oUW3CLr5O0QzInsOQPjf5U1HZeVvJX9fmmkCqwr2978ua0z4Zj1Qn3U9FbXH/U9nYIzD
         rZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769465083; x=1770069883;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YG21uS5Q3aTxJoxgOLQVMsuQQQPt4JTzGp95ovsFsE=;
        b=PXTIWhp/tfvUDHpNNP3USe7au/Jc9haPGH2dpgl4JxqapVEa52baDomFVpWXG/WhG9
         7RJ0hhowIDyU1tENHja6zUdiZS2QtvahBIllC1YKaZIAn4RbCSK8Z+aPFGAwhN4ylMWh
         9OnmJp9atieh/az98oc6IDYQx6Te0mcujoGdLc7yC6JjAkfCQQ/u7q7i03BRBnmZ7kSv
         MY9zz5neiJ3KZ2G37D3e/jRxZer5nEDb31Levcp/vf0O3w37cOjVU5TcQzm5vzzM87Nn
         CTJ0gjfvum1/WY/4wjRRWJ14JtW7j2K9qg5BT/yjD0JPCmrMzpoCuok/hEBJOVQkqhOb
         HuIA==
X-Forwarded-Encrypted: i=1; AJvYcCWC49AhgxFuqyMpMXRLu86a353qX38czacvkcdjsS1GNxt2SHX4iH1SxCG4fZ71aIgsU6F7njc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ16K/qRCADPYhT8fbVlhAVwDflsX13NoMomKtJAkc3rVP9XbT
	roG6wGBijvPvwZaeJU2WvoTC9npRvxChYsv4/sHJ6uRpxLg+SOPUKNDh7uwYlKnzLQlB56QOy9f
	UBy04uC2TN2FziuQGFnfw3gBn8JjXkxc=
X-Gm-Gg: AZuq6aJxmp4HteodhLxC0Njph34tBD9etit2pyNqAIwTXsS0s6hsm4CxG+9KbwW0fud
	Znebp1zYBgGq3ohVbeuriIb07xpkUziErUg7n9JZlvw+MbFAHRU8MvcfPPJj7xhgbe6Dlt8NNXk
	qjswaPy4aCVa2QJNhHf6tbw9pyO2vqgxf+J4C32mwVPZoH9J6ug48fEtmFuvh1Rz4UCK1KpD+zX
	WS7rI6ezxGWsx4fdzaR3ij3B+XfFxt6UN6Is32N91iX+oXR3AVR6kVkY/o4QU/IcD/TOQEyJ74x
	lBbCbttyG8H5PlBs2AnnzIM8AOAA
X-Received: by 2002:a05:690c:e3eb:b0:794:2c3d:7952 with SMTP id
 00721157ae682-7945a845df7mr47379077b3.3.1769465082722; Mon, 26 Jan 2026
 14:04:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125233335.6875-1-chris.bainbridge@gmail.com>
 <DM3PPF63A6024A93B1437A144E82CC38B7AA393A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <aXcovK8uhsiaHumT@debian.local> <DM3PPF63A6024A907097A88AEB32669C1E5A393A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
In-Reply-To: <DM3PPF63A6024A907097A88AEB32669C1E5A393A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
From: Chris Bainbridge <chris.bainbridge@gmail.com>
Date: Mon, 26 Jan 2026 22:04:31 +0000
X-Gm-Features: AZwV_QiceH7qsXObZwUw3W1_GqQzTM8Z2nnHyRpegpE1rqs3Px19JUyms_T0uKk
Message-ID: <CAP-bSRZ60CSEtR-_9OL6k_Lzg=w8MtD2i79KpwF+nYYzgak=-Q@mail.gmail.com>
Subject: Re: [PATCH] Revert "wifi: iwlwifi: trans: remove STATUS_SUSPENDED"
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "kvalo@kernel.org" <kvalo@kernel.org>, "Berg, Johannes" <johannes.berg@intel.com>, 
	"benjamin@sipsolutions.net" <benjamin@sipsolutions.net>, "gustavoars@kernel.org" <gustavoars@kernel.org>, 
	"linux-intel-wifi@intel.com" <linux-intel-wifi@intel.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253604-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisbainbridge@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 23EFD8DCF4
X-Rspamd-Action: no action

On Mon, 26 Jan 2026 at 13:45, Korenblit, Miriam Rachel
<miriam.rachel.korenblit@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Chris Bainbridge <chris.bainbridge@gmail.com>
> > Sent: Monday, January 26, 2026 10:42 AM
> > To: Korenblit, Miriam Rachel <miriam.rachel.korenblit@intel.com>
> > Cc: kvalo@kernel.org; Berg, Johannes <johannes.berg@intel.com>;
> > benjamin@sipsolutions.net; gustavoars@kernel.org; linux-intel-wifi@intel.com;
> > linux-wireless@vger.kernel.org; netdev@vger.kernel.org; linux-
> > kernel@vger.kernel.org; stable@vger.kernel.org
> > Subject: Re: [PATCH] Revert "wifi: iwlwifi: trans: remove STATUS_SUSPENDED"
> >
> > On Mon, Jan 26, 2026 at 07:15:54AM +0000, Korenblit, Miriam Rachel wrote:
> > >
> > > Hi Chris, could you please provide the full log?
> > >
> > > Miri
> >
> > Sure, for 6.18.0 see https://lore.kernel.org/linux-
> > wireless/aTDoDiD55qlUZ0pn@debian.local/
> >
> >
> Thanks!
>
> could you please test if the attached patch eliminates the panic?

Yes, that seems to work fine.

Reported-and-tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>

