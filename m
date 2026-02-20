Return-Path: <netdev+bounces-259813-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKvKCWAVmWl5QQMAu9opvQ
	(envelope-from <netdev+bounces-259813-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 03:16:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AC716BE71
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 03:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1663303BB04
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 02:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDCA21ABB1;
	Sat, 21 Feb 2026 02:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfQV4gkQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91BE2D5957
	for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 02:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771640156; cv=pass; b=aP+CFhUmxrT+1jA599BZlxyEc0hi4s1qqulmuepf6Cf0rUR/KEFEm7TffGxOhYFaRIGpf/vVvXjwqaCzRJ4RUXz3QpjieFdHfos4sB9Mt8Ayyg90oNZFACt9dkon0qOLA1Ky+mZ7hUS80UrkgM7oqV+e51TSa3oP+4VsK3+nwwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771640156; c=relaxed/simple;
	bh=cwVJpYds9WRhqGxgtRAz+YHH/axeAs5tYhVkRL3n+NY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nplC3WrGkcidYIfyjPHMMpeLR8DK5u/ARhhY7doGPI1do9bzPoGfsnxJFscmcGJsOnJj2vWwASYLI6hnhJb/3p15JRJQ+g42Qu2s5BGUJ3+tNM6Q2CXHPMZ22nG7G9iPbfM2UJRH7P5h80wf2RpT48YYabjkuu5fRkU5EqCOuew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfQV4gkQ; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8850aa5b56so485001566b.2
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 18:15:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771640153; cv=none;
        d=google.com; s=arc-20240605;
        b=EEY5fX1S9zWgxObFCJ0uQMeO0m4PC0NLdmLctTy9yk35T1+J2Stbdgbzk/qpzNjW+R
         FXwHwlW0ejfxzSvqDdVn7djE0m8KpiY+UbVCbiYTzI/72tGwqkV6ucalLNgHA6G1U9V+
         81loDr1rys0yo4r23BirKNuD3XbiS0k5pl2e5PJXySZCG7rUGbuEMTnnMf6IrNnSvxda
         mCaWQlOTo+FIR9ERQ5iBkmvFRg8ngLfzK84wyfpN2037y2oXbaTNC9+ed31QYrau67JY
         GCfxr3KgGsUESOhlrY6Id4BNMwkzHV8DBhMtj8lyLesYb1U3Xpxy4T0q5tbazYM915Ou
         zB9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cwVJpYds9WRhqGxgtRAz+YHH/axeAs5tYhVkRL3n+NY=;
        fh=+iyTqnHstk/Gdj3f5FCvurJzonhteX7gnW8NJlfVBDU=;
        b=EoGRZza03yQKD5l4ndZJqkPm4xlr12OZvqILorinjBycVEmORK5qkN0sBswhCsQtfi
         Qx5hKB9sbvJkmMCbeuAvrxmzxJL2pBQWMEjL1TnI8WO+ieiAvx7Oly6HZz0dAmon56VV
         SrMSE07iRlO9vVSkCIvLKuiQqw4ATGfd2RSp77RR65ojB/HLTnoQ8RgkygnXm6QnU5ut
         Da1sm1hQ6Iu43pbX7FD7IB8b1GXpHLVSVjXw+CFP25Wnfp6vFCGOHZ/QBeVFSrPkehwk
         U1G1rh6BogKpnGs1GKCxKKnYCYN3gm1ROEhSv+i9LsfLUdDGadbEr1w7mnRzcEYxVmsh
         67vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771640153; x=1772244953; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cwVJpYds9WRhqGxgtRAz+YHH/axeAs5tYhVkRL3n+NY=;
        b=NfQV4gkQ+/Lyk7eVnL/DiyVroz58r5jwR19LKO1YVxm9JzPsNR/8RX4LIdeg+9FlSB
         /1iIu/4tSSV9ceA9QzLKDyH0o0cK8pOcDg4nUt7zUTNHtQE8grAsFwH3WChp5Bm3Hfhj
         Jnqvc2VigJPGxYaekcVCAMyeNy+WhTKn59bW5eqn660muAFIXvNd+rsmxvSjTl1nPnaz
         CRzXkzyKC2Lz4mdjBHp+hkgNJAyb9a+YSf2cmfP8nRwfUUoTjuJIBgO29a1JrjcuFn1Q
         mxPcpZtq0dXD2OURsniMUfNfnFvl9wTHXHof4YlWavuJISW6tgd7GHP0+wUtnjAsEiQm
         pCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771640153; x=1772244953;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwVJpYds9WRhqGxgtRAz+YHH/axeAs5tYhVkRL3n+NY=;
        b=IHVMn0lzEIhNa27kux19JgoBt+MD5gTIpIr71j7EloqmxTlUb1R7oALgsfA+kZ/JSe
         QImRXIv5p2fVs8Efxi93WfDcPtTJ8UNs97iuS3zLytBCcSjK2+h0Z+npswAkPOGqb95w
         uZ+gJ2UjK0nzEjn20GAMuJZiFOuWpy5VN4kY9JkEai1O+cktvwDjYczm71hfQmmEKudt
         fBqcsTvZtI0T56wvmY7J8M+qacrrzj1Bbx6DV5KzTJEwHfd1yjlTf0NCQpy6KMrASKEr
         QR5h4JcynTg5dvUzmDZ9DKCus5uOu6lXKctMMXx3l3gPFuruHmzQ/Lo072ewTD009pVf
         fzBg==
X-Forwarded-Encrypted: i=1; AJvYcCX1yclpslerfaNEPuNHPeIFgIyRf5r56xxY3+vhBtSOr2tNWvRlBsRmbGxXZGHTwUPODjNMRT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjFTrxHo3rdJo6n1NfwrDWcas6+aWahbt+XapWfi50V0zH59QL
	Slfq97L9Ncftaw5mmaqV1RiiLseDNtbSA6Jl6tffhht/j0lHmMCKYtgTBAnolwMYDKL0+Tozo4c
	6VzZw7VE9bC7UU5T1c3E2T8jIMh85cUo=
X-Gm-Gg: AZuq6aIJftb+O281sEzIX1r6BfyvzeiPqy7JkHaRGzwoghbxnFGR19ixfFF78dYkuA9
	OT2LWM4WKXgbnRbh4H24ApHBbrSZ7b16lKAiDKYQsvgvRXE8HCZJmHhlaj3dZJaOPEzzXQH60nH
	lNqhxee7RFUWV3AB3SGHvbK7fecDuCq6N3R1u2Rv9GxGCJYvVa1iia7P0qyNcYzzjDEWc0RVhow
	gQX0PvFA12dw6zOQhJEnnCXQWuVSqX1AIXYb3OZqbyWJaSKg+bJak/98G6TRNmA4tdCExKCOjpo
	rD0MqZ1G1/FuumX2N4trYKoDQwlzHyxhnXyiM5mARbUzJzgCPL+RW20M3AKjejulMXvsiO1+Kg=
	=
X-Received: by 2002:a17:906:4f8f:b0:b8f:70c0:c619 with SMTP id
 a640c23a62f3a-b9081bcf826mr57406966b.52.1771640152852; Fri, 20 Feb 2026
 18:15:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260214033859.43857-1-jiayuan.chen@linux.dev>
 <aZURjBHTHRvjP7Ee@mini-arch> <20260218174025.2fe593d3@kernel.org>
 <aZdddVNRy6sYiUEt@mini-arch> <20260219121213.5b5ab0e7@kernel.org>
 <CAPrAcgNP0av_d+Ai175QoEu5shjHXEEtObtqkhcnKufpHwHWDA@mail.gmail.com> <aZkHFB1yH2ooiukD@mini-arch>
In-Reply-To: <aZkHFB1yH2ooiukD@mini-arch>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Sat, 21 Feb 2026 02:15:38 +0530
X-Gm-Features: AaiRm52UQSJUE8vaQr6WV5HgUrfDWWlGtsDuWtCL3urjMblSAGcISCnDA8aO7iY
Message-ID: <CAPrAcgOzEnc-XPNG55UtzQMRamG4pTzZA8PB71WuzjGRSNmFjw@mail.gmail.com>
Subject: Re: [PATCH net v1] net: defer __dev_set_promiscuity() to avoid
 sleeping in atomic context
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
	Jiayuan Chen <jiayuan.chen@shopee.com>, 
	syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Sabrina Dubroca <sd@queasysnail.net>, Stanislav Fomichev <sdf@fomichev.me>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Ahmed Zaki <ahmed.zaki@intel.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259813-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viswanathiyyappan@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,2b3391f44313b3983e91];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 77AC716BE71
X-Rspamd-Action: no action

On Sat, 21 Feb 2026 at 06:45, Stanislav Fomichev <stfomichev@gmail.com> wrote:
> > Do you mean rtnl_lock when you say instance lock?
>
> Search for the instance locks in Documentation/networking/netdevices.rst. We
> essentially need to add netdev_ops_assert_locked to __dev_set_rx_mode
> and make it work.

So, the handler should look something like this?

static void netif_write_rx_mode(struct work_struct *param) {
 rtnl_lock()
 netdev_lock()
 /* Processing */
netdev_unlock();
 rtnl_unlock();
}

v9 should be out by next week and fixes all the issues I could think
of so please wait for that

