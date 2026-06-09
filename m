Return-Path: <netdev+bounces-297146-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2s8DLFo8KGr5AgMAu9opvQ
	(envelope-from <netdev+bounces-297146-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:16:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 117486623AB
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:16:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=NQQMsW7K;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297146-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297146-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF713314DE55
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 15:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CCA492529;
	Tue,  9 Jun 2026 15:44:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E6849250B
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 15:44:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781019897; cv=pass; b=RnPz1R+/sMchUeJzitXSSZ9uyeiAHsUP+OCTiSw1EqV7szEV/PHrlWvzh2WbO+OiCdzUN4DCxFs5sX1W38/rJTra8ohsHYTAOyJO2VDWZ3yRNJd6Znf0b/DSnZW3TsI+268KFPmkoU6n+N4hReDYL4EVyCMS7OdOw+VeXcStA3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781019897; c=relaxed/simple;
	bh=Cr6iQlmlZuAmGGbgRGvSeO1Ej7tV+97ogH6JWNriwHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CScJ/iVVUTCJsl39swNeo64HZiKJHWxjCSm/ahJBhi5wlQ7Fzi7rc4aOjT+j+LSnfu8rbjLnhk0r2MOlW5GZK47HOTL4cOJbaC9ZASANOJu+3aYlMk9xdpLb566uFPQ0/m6lk3r+CcjptoW+kMLo5te3ogQO6/27E1C3XRJkNTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NQQMsW7K; arc=pass smtp.client-ip=209.85.160.182
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51764768c36so75470561cf.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 08:44:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781019895; cv=none;
        d=google.com; s=arc-20240605;
        b=Zhljjgk3MngtU/2S7M3nUftFLsjIxo5Px9kFxQTq10uOzp4iJK8gjylXS/8GTL9Zyb
         Q+krKLORD0fjUiI8G40mJqlO/J88zUwglx0929rmqYRRYdexIs8COCUSKYx5/dUlWwSS
         2TQFjuDOMOr77NCBXc/bzwxFpZs6k44KvG6rh8trMRegq04mjljPIUHkakvU3TMwH1bp
         4wejJN9Ss8ixvtwBM5XDWLdTofLUrfVNkV+YvPEfYB0bXs4gOR3j7cCX30lrK4xTYVLF
         xDLPjSNWxyX1OuoNmMsRRnv9RJ/pObPlDxsQJAlx35Ue8GktH0q+fsuN/2gup3I9pU4z
         fUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cr6iQlmlZuAmGGbgRGvSeO1Ej7tV+97ogH6JWNriwHc=;
        fh=z9NJROFCjCrwayl9zUk1nwJ5i2oKpRYgFrCu4i7GEkM=;
        b=a0RUdPb0EVL0jUQyw8dpSPaIIhx9xoTdJYbD49I1NB9FFv4GUJibtmJzPjyRbw3bKw
         KDw8RSs2DIUckyMhTkE2Yb1b7Kk2qDJ0RyESLfQQB66T2krX/OCkQ1VN6TwFFfRLKp/9
         n72u7u1fOiswWccG6+o8c3PclZe+k/jtbGuhp6uIxlotiUo22A/jACxmOazyW/9Ij+v7
         D/o3KQaw6WT2LXmFow/Z6eguvHAoyKeJ/PUn4ruDqfLkmqSdV3ByIGT/Txuk0WZLOC2M
         2o/hXLqpEgkPSSQLbPyk6ptVtBrW7CCn5a/RiONKDjOJUV0hI18KuoclJU9kY1OknMiZ
         MsTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781019895; x=1781624695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cr6iQlmlZuAmGGbgRGvSeO1Ej7tV+97ogH6JWNriwHc=;
        b=NQQMsW7KEYpb+fuBdsvzTsGtp7LJq8giFQkUMoXcoAAO/WwuaYO8qpfyEWdZ8dI/2q
         fULmrzCxDnv37mjKE00OjGLZ9Ou94Y7isnN+zgGLSVDuRrad4PHOtpUYzGIuPMeip9qL
         AprfRT9kzTOzkfV7RcQSAl0OVkZ6b8ZAAqqiG24yRSNftTTb9+hCY0YoOHQhfL+zO0Uj
         lzTG4C5L82aRXVZzefCiHwblksGRR8ZVG6qgtRWFLfwAvq3rj/IRUlUv+8pYzf4p+Cse
         wbeVXghXCyoDDd5WxwZT7hmgXB/3LBoMtaaxW6SWx5kUb/XwPQ2DUDQtYJZg8YRk0Fuj
         yY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781019895; x=1781624695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cr6iQlmlZuAmGGbgRGvSeO1Ej7tV+97ogH6JWNriwHc=;
        b=W2LDyby5+l4yxPWAPIpmlKdoBSTtQTZmkfeOgelJHI6yoxckuOk8EVJuLIdiBKyWU1
         nPFRADiC3kF5E0fIP/NY83NiwmNon7jjpoiwJ44AHM3oGp9SR/05r/zOriXqvtLfvRYX
         7Bjjc7ZXYIoRLVkkckx0EtZ5kz5cMVdyq3NG2IEJkoL/ucYSmF7lEsWHOKEQwShQy9kT
         kNEBrALNFvR+9/Ar6CKqwi7xR0DIDsByPr35SUUVcC0bnmICavLSeynUMjwVRsV7upEf
         vhjWzmhYVBv1ahDdmb3iytHKZ/ea2VIZ3wfeGHI4CcrppUdCS0J/2ZbMiWWilYbcLS+x
         YHyg==
X-Forwarded-Encrypted: i=1; AFNElJ+XX8P0N4ng1E+R+pTHDeOc+uNaFuJ+GgdZS8Yg9BW9XrYWlQDq+018tJBHuvDpem10P8p3uBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPLcnSvYWMVYE5dmqAzk1rqPJMiECViiwi6N7Ghmt74cvEF3tr
	h58dkyUmEaRUcZPYYeeIx2SpkSUbXIkNOX/IxwHzg/+6BHRr3zlqyzE8gFe7pLAnZ6bxWsgQDFW
	DS+7DnxQnhx6gOJnMvdAds2F9SEHy8t2d12/71VLA
X-Gm-Gg: Acq92OFeWJz7BB4W0sAsbXcOhwhqik7VgHKcRyUB92LAZtcFeTTfRTDpnpNi/xCHlNu
	txngZKqhAHC1pfQFcR2vKKABKTMdDOFZi9nujN0woVpY4KZpD7weSmXvOlTn/jSuEwimzmNs4Dm
	J0+vrECb/xDdzs14OSVRsgsQxC1dvViGpGTw4G9OWDHb80GBMzr1qCJQbbt+zIl4iDMZ5enIlGN
	YqD5Drg7yZ6yJQEyjuGZY8LjVQAam3anYRkeaeRld/MjpVxGv2AlY9Krllk1XoCkKuCyACJ7QQg
	GQNGfpvdX//oSp6fWMzK+Hei/WoSGWSqMCRdRToRY7UiOWfnlc3zO2RsNrSWNzIby6r64eqpc9v
	+ASeCTBGsk4E7DdVB7D//7eWJU31pAg==
X-Received: by 2002:a05:622a:6096:b0:517:87c4:2a95 with SMTP id
 d75a77b69052e-51795b4eea0mr308475011cf.5.1781019893845; Tue, 09 Jun 2026
 08:44:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605002912.3456868-1-kuba@kernel.org> <20260605002912.3456868-10-kuba@kernel.org>
In-Reply-To: <20260605002912.3456868-10-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Jun 2026 08:44:42 -0700
X-Gm-Features: AVVi8CeXKStJiXyhYMOg1yF7xEuRcmimYVUYvQdEPQStlFBdEt9jGqxB7-Qoob8
Message-ID: <CANn89iKXKT2-e-h1GJcg7UMS0xZG5eNB4aG2pE_G6TwKZvoUug@mail.gmail.com>
Subject: Re: [PATCH net-next v2 09/12] net: ethtool: optionally skip rtnl_lock
 in RSS context handlers
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com, 
	hkallweit1@gmail.com, maxime.chevallier@bootlin.com, joshwash@google.com, 
	tariqt@nvidia.com, alexanderduyck@fb.com, willemb@google.com, 
	jacob.e.keller@intel.com, kory.maincent@bootlin.com, sdf.kernel@gmail.com, 
	jakub@cloudflare.com, nb@tipi-net.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:joshwash@google.com,m:tariqt@nvidia.com,m:alexanderduyck@fb.com,m:willemb@google.com,m:jacob.e.keller@intel.com,m:kory.maincent@bootlin.com,m:sdf.kernel@gmail.com,m:jakub@cloudflare.com,m:nb@tipi-net.de,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297146-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,redhat.com,lunn.ch,kernel.org,broadcom.com,gmail.com,bootlin.com,google.com,nvidia.com,fb.com,intel.com,cloudflare.com,tipi-net.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 117486623AB

On Thu, Jun 4, 2026 at 5:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Skip rtnl_lock in RSS context handlers if device is ops-locked.
> Fairly trivial conversion. bnxt needed rtnl_lock for changing
> the main context but looks like additional contexts are fine
> without it.
>
> Note (for review bots?) that ethnl_ops_begin() checks whether
> the device is still registered.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

