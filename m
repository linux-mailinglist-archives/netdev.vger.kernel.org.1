Return-Path: <netdev+bounces-289947-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eze0HWi5DWpv2wUAu9opvQ
	(envelope-from <netdev+bounces-289947-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 15:38:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD9B58EEB3
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 15:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B89DD3013ECF
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32A72D8391;
	Wed, 20 May 2026 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LGn1XMEq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2A62C15A9
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 13:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284131; cv=pass; b=tpXwbBrouSizJeHHW8E5eRksUz3XaVFr4jLMDPJ95O3ZTZJHQOgjMS4GPcFZLyhnf20aNHaNqsseC/HuOW3zSTeLWDrK2LFP4+2/FA6g3YguCPdntisQBymz9LqgEDxUo8KXRPCWQWVjuTU3roxoDxJh2ZJK9CWkgcw6ctcD6zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284131; c=relaxed/simple;
	bh=TaewVaaJSRTgVv7uiAvCvNN525apvixVpdwb+G50UPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bH7M472NnuBSGlFXVkB9XfoYWroJyPse0OD9kexeJPgj7Hvexx3pTPUOxNnXi+SlneGASX2nY39jysNUZXOi/OEyz/2z+1CHCyC1i90yo21lo33HaErB+Zl8jhFNYCbB+A7Opf2hV7+QtSa04cEQFhrw0lrovO3tVIM3SnZAlgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LGn1XMEq; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a74ac8b40aso5456852e87.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 06:35:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779284128; cv=none;
        d=google.com; s=arc-20240605;
        b=VXzjzdzxINLORxSQZb3nKQ7EJCk98V1vLl7oKfw7f73tao+V8HNxlDWe1YL4ZJcJfX
         9jJUuRdDF7hcYoqYCsCR/UN07wjn8MxPjmTA2VMlfrIXYy7V+AYzyt+7lT8k7asvz/GC
         1ypE6IIeDZ9uEpll3dM7S5XVDCP24PvzqoTJmyA9eB8aPglEsbq553YveCEBsyTHZUm/
         Us/HuNEukk89SXA9HNKLOwSQ1Gf39MPKnTkHK4MwEPVGkQpPZyLKl6L4+Rc1shv/NEkC
         nZluf2XqEdZY1fc5nipGYiWFYLJo3Bp3USvoJe+2E8y7krAGJcAoyF0NG0rUNB/JTImt
         WBUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yu0/XtO4dIfAu/cztcBneHSKuN0SeWCUAeJO4rKJAag=;
        fh=lkHr/KJ4ZJxBrnCcPDBKosKqDaCTv+CDnYwd29zfdo4=;
        b=f+iwkbHPk71zKv61UQbUehmwDN5jDMYnvlACi5cds53WtL0NGNm8vwtLvnIeUBv4QS
         w4GufqhPuEj3rx0780axB1Ah3kBlRwKRDhDN/Acgl8t+NhntGEvglWorVQQo6kDZTH6D
         2fHFj2nbrL4TCgTFcLSUfLTmzI/5hCxpqxYvCEJtTCyA/UYaoLbrCE+e3bM1hbTsRg7H
         mLRNAdpCogEa72Vyzy9Po1M4m/szkKtyQ9uwuwAIC5tf9VySmLRajv3+Te7O4M9S3T4l
         +LNEf+dXcb56FcjrYBqAR4eUml9ct/cwunGjYuNAuzDZzJc4oU3tQ0oRYGNwycr97UM8
         6nNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779284128; x=1779888928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yu0/XtO4dIfAu/cztcBneHSKuN0SeWCUAeJO4rKJAag=;
        b=LGn1XMEqc7BwAhuIEoaGJz1Ki15lwdTkwh5ZqSasJbAHLIPYwItSy8PyDWIqj7TiRL
         +/tqPFnreQHSqMjI+CDSKlR5UmBY80l3eOzhsVNwsHk2hFT3IMlzAqjI0HAw2QdbQLWy
         xluVpgZ55mwkiBKrJNRzafPc5fdTSbXQfXgOIhqvjd5owAMLxTmTEYriHrHqu048yPpp
         iYwowOEwcgfbNesWsaDGvFmot3AM/WxdRjaM24e/8Ubil/X06kWrSLd6OaUIaM5S3+Aw
         skpgfWDVFbWWvacsKCsNzYkSWoI4yjb+kPgO3iPVHAv3bj2BpJuNYTXL2/xW2Cr21+8U
         BKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779284128; x=1779888928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yu0/XtO4dIfAu/cztcBneHSKuN0SeWCUAeJO4rKJAag=;
        b=FR64afJsxuMeFOGN++uxVAs+yv8IRZKkBqJeUFg+R5Gl5k780/bbyPFo8q6heq/u1w
         EPdxG30SFbGmEod3JhatpYH9RGChGSYa/xutu0o4DDzZPaB6CqB9H+LwErZhW+nExf0S
         n0xycsRZtLeZPuRVYyP3F3Miz+PwVE4FK0w9Ci37pGuf8djSFUSMKfHSS5dl+TdBzWpd
         90ocCGhLdM3mj5P+mDC5NLymyh/K5swXggPhsX5EyKz2vV0eQ4/yv8nUYAjyhgKw5F9/
         Vs/pmhf8DRj0dCAdRrvKe/hT54+1nHrx6TY8ofVuHnAmEP2LREaNiJZLAp+vNUAR7Myb
         P+0A==
X-Forwarded-Encrypted: i=1; AFNElJ/nV7GTydFHVrP2SYtvDsGjjydFQWzSF5JIwpQL1X+Q/kY52tVxNDVEGMnf/DvdAbmjYU4Tm9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuaWLcUTJvSMAMxRgsJXDjpjOMaQ1g3EQ9QwdNydScfLuSjC9p
	HVG6e5tWJvf2P2cqhye356im0wXm7NN+oIi4Aj8NTIrm9yweJ0WVD66w2TCNR5pO2izS0dChXyz
	aHL+oOewXY6Ote3z2yyyt2v+UbdN4fuPa9kTQD9FJuA==
X-Gm-Gg: Acq92OFwwJsHHL1F4JCurMnyJuFyFoWdBmoGRn+7Vj9si2ttb1rM4nnAwnCj8fnZcHq
	+Ox4CXtW8N53UNdRmDaM8xazxrxrpk6Dp/vujSaRHsoGlbj6PzF0Ngr+4woEGJwPKcwNdkjSy5o
	2UzwouK8OuXbR4+5WXoM69M5HjWVFT6/LUWU3ROWkHN1RdRsyW1al6XoekhonuB2clorAxHhHro
	hqECJ44CQoHJxxqpzUDo6yzWU0yjjfE06XaTxhM3oLuPGkyz+VtUXT7AvEjGorU9yzMDTcuJfx3
	nR4GHLvLqBEdzawxDuE=
X-Received: by 2002:a05:6512:3d17:b0:5a4:1096:94e4 with SMTP id
 2adb3069b0e04-5aa0e73f375mr6835140e87.2.1779284128482; Wed, 20 May 2026
 06:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515135143.259669-1-marco.crivellari@suse.com>
 <20260515135143.259669-3-marco.crivellari@suse.com> <20260519182219.0d685a27@kernel.org>
 <10173685-596f-1eb0-0903-a3d7ba4dff9b@ssi.bg>
In-Reply-To: <10173685-596f-1eb0-0903-a3d7ba4dff9b@ssi.bg>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 20 May 2026 15:35:17 +0200
X-Gm-Features: AVHnY4IeRKHo331ej-I0dmnws79oeyR-8QctDEsIk4GCUGbIHbl2IQWDS5Yw-jk
Message-ID: <CAAofZF47k3FiALNvNzaU8W=sNXXUH2Wfx==0G9qJAGM1rFOS_A@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/2] ipvs: Replace use of system_unbound_wq
 with system_dfl_long_wq
To: Julian Anastasov <ja@ssi.bg>
Cc: Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Simon Horman <horms@verge.net.au>, Eric Dumazet <edumazet@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289947-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,linutronix.de,suse.com,verge.net.au,google.com,davemloft.net,redhat.com,netfilter.org,strlen.de,nwl.cc];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ssi.bg:email]
X-Rspamd-Queue-Id: 2BD9B58EEB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 6:11=E2=80=AFAM Julian Anastasov <ja@ssi.bg> wrote:
> [...]
> > On Fri, 15 May 2026 15:51:37 +0200 Marco Crivellari wrote:
> > > Subject: [PATCH v2 net-next 2/2] ipvs: Replace use of system_unbound_=
wq with system_dfl_long_wq
> >
> > FTR leaving this one to netfilter folks
>
>         Yep, we wait net to be merged to net-next because the patch
> depends on commit 5522d65d81a7
> ("ipvs: avoid possible loop in ip_vs_dst_event on resizing")

Thanks to both of you.

--=20

Marco Crivellari

SUSE Labs

