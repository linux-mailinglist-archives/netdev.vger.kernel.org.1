Return-Path: <netdev+bounces-253406-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yE/9F0Q5d2nhdAEAu9opvQ
	(envelope-from <netdev+bounces-253406-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 10:52:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D880B863A3
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 10:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 071D43019FEC
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 09:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D741B32D7FA;
	Mon, 26 Jan 2026 09:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DDh9TbMf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5127932BF22
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 09:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421092; cv=pass; b=B5gYi8DTXjrxOzOBfL55RwsdM6ECO9nVSWF/rKYwSDLRt8BM5BjWdQU/P2QRKMlP2r/Q3+b8iKMLm0awK9lPhWvH7G3PGBPE/hAuTLI0od8hUCrOWS02JxInyF600nb8nFEJjYrSL+UcycGNKWVhP4tamzKA5ByCZJDtvpeBvQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421092; c=relaxed/simple;
	bh=R4m3xAHpZRktXg6t2RbX0pRcPJIu5idPDcFCjkEwSGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkE3glcxiBHyH8HXT6ya+Xg4YJHFA8M52+bqeBAFkkBMkP/wW9rxeQtcDYQ73sFnB43e7z6h48jiwbqQteurJptkwmJc1aOJbmm7E3YqcoQsMsHibhqJqbmzfYDWfLeedx2XPyL6TGjQX1Wcx3wKjBzvzh7OkEj+YNMvoYc98sI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DDh9TbMf; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-502a789834fso37484901cf.2
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 01:51:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769421090; cv=none;
        d=google.com; s=arc-20240605;
        b=Vc6QtuWixglvgLk0aHL3tjB17hzMyT8xaqi1AoQv/BtQNRowIQxXfwaMoWbh4fQVdL
         y0CCi/LuYWDIznxA+559EYlBhgy/6CUK2JB7up+K1Vo1r45yvXz5UrnlOVmVLJGfZGs6
         m7ELLTwhgwC53Op6pfFkBDEC0/HTvK2KQ0Cg3LW+PhnA4DbG0eygSS0IxaAEHwACYYEa
         9sUMPeeCouEtu00sBEBO7HyH0pR8vf5Y0NxoMkIZF3iMampepmAmAngiGOOovrUX4iuq
         Iz4DYdxQWbgeEG8W13p4nIEvMsjSeuMfiMT6GRkJ3X7EgD3+cZVBc8t4ZuBcxBrAfcYi
         kFVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R4m3xAHpZRktXg6t2RbX0pRcPJIu5idPDcFCjkEwSGA=;
        fh=coVQQnhgWwBCGiLnd9QPTYWxb/gSoNg7CzXNYAJxWyM=;
        b=F80i+RJFo2zGW9pUh2V5816JyWCWESZ/ZbXV4p5vX/QGOysHataiPlc1LyLcivtVYW
         KisEYpMzIN/dvlatAvvIb9VXgGDgUmywvhcNkW5bUHooo1A/GAWSYTI3JiYidy1u0kEC
         BePaMLdgdAhA3f4+Npn3Cdykh+7M3yDHFh/sdhFYnXJzoy3erSaPTXkyYEM0pk4pI58y
         KcBMfOmmFIo9rBLC3at5tVSfSzlg15ym5jHf0Fq5EyBc6E7VeLEwyhP3SPB15JUZ3F5g
         FSzNy/JFBDJ9tjTxB9vp4Tf1tLQRoh7Tf/nx7G0n86iMjY6DiXrUlwWAYlOo9pWMMFPL
         wX7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769421090; x=1770025890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4m3xAHpZRktXg6t2RbX0pRcPJIu5idPDcFCjkEwSGA=;
        b=DDh9TbMfpRNLI/Q3D6u7Gju6ygO74XJAmBllry3yRF61b2dE3YLHhuigiC5iGffR/p
         ei1vDk56P8Xkma/pWZYjfFK0I1TCg15+MbBwZR51WXDgTOlC+vPq8haG6uZDMVzKjHwh
         ytPC22Cy8ICKSFp7nBOkW/4KsKJFMSEkEKZ3eUGpUTun/fb5YBp5EUenu5qt5cdCWpzH
         L5cVJEwxmy5ntE2Xl5Vo7kiNiKkio51KbtAXcYquI5NhFmZ0+LbvBCPUHDlMOkbmfPk9
         jqkwVbck+19sQxUJOZh6cHlw88mEt8XmnkbuM9NPX0sq5sm7bBKTT13MpLj+zGKq2TOO
         GzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769421090; x=1770025890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R4m3xAHpZRktXg6t2RbX0pRcPJIu5idPDcFCjkEwSGA=;
        b=rm00b/7E9vdQY62jpe7NGOoX+hX6HFpmpp+ii/2NuyRXeiRKOGZ5JJpRgGzt9AkxhM
         p99yyki4ZNZ8mpuXozUfon5JCvRVNZzt6qolZiDrBscxqWKU0Z4Gq7hl8sZ8yp8ZY1CT
         8ECv4is8YdMYZD4PE8fIIKmfczcw2bCey8eAW7qD3f4EM2sOGzq52siuISpEoJ1ew7jT
         FYwFiq/ROro1fmYq74KvFomUqJHvOSzVxL3qldTtp3Tluz+PWVCNgqMedoYNBTd3LtA5
         4JWXNTtYposs3eYElxPJDk+20GmWqpBl/CQAfC5XdMZQWJtbqZ3IihZALYSxA44ItIID
         JjRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw4nJLOLPLLIDyElkUEFcBmvtOALCs9EpwlXchp1ZURKYCxYdpk+LkdYxTSIuFuFDf7nDv1R0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzclwFmySeTQ1eRAwAhcOCTSxBvCLuZOXDfsVi50X5LHTEjs9mE
	BhhB21cf9aXvRTqbxfchB9BFcrdUJKEuJYIu1wgavVRUCjO3mXpfMcbosJXpUTbUVMRpZsLHO7o
	aQOA++NAdq7oU4b+SAsvDrb0DF9E/ZFDJuilNVhvg
X-Gm-Gg: AZuq6aJBuluCtigXkRBEGDZq9S1bGDk+gG8wEzruguvknKuJXQZL+wMBqBbQPeKu/po
	vV+EZfX8VIdHsTrG2gPn+EEYPYkzpmZ56PBYFwwVcjGOl1ae0bmUjKjuzFQhbtbq2o5dUuXA3E1
	ZKwkyK6m1v5/veRaVY2L8w7xpNHRxWrVkXnZIoTV6xBPWVzuoZ6TahNzaEC9mSs/sK8p1uz77TC
	EilQAyykx2qi1BxxH0qCMu/Y7fRcfNsWYmDtcmb6BQNE8d82K/Rcb0cNGls45/jIAJcihtH
X-Received: by 2002:ac8:5f0a:0:b0:502:a299:3937 with SMTP id
 d75a77b69052e-50314b7a488mr46484011cf.6.1769421089873; Mon, 26 Jan 2026
 01:51:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGfirfeHMgBUq-Q8tCn8dr2tHVJdQtZbS0JMutqF+b04T3EoWw@mail.gmail.com>
 <CAGfirfc70aJ7YUa02ObbxPfkH1u6B=BPZpUXDAg2FU16aKvL1Q@mail.gmail.com>
In-Reply-To: <CAGfirfc70aJ7YUa02ObbxPfkH1u6B=BPZpUXDAg2FU16aKvL1Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Jan 2026 10:51:16 +0100
X-Gm-Features: AZwV_QhoW6y9dJF92KThKWLM-xeyeWqQdHuRiD05sQswIeaD5u2k60dYy6cQhZY
Message-ID: <CANn89iJrXSHouF4ZnnoVYz4Q47J5jkwU4OuXMpJi3Orox4uT_Q@mail.gmail.com>
Subject: Re: [BUG] KASAN: slab-use-after-free Read in u32_classify
To: =?UTF-8?B?6rmA6rCV66+8?= <km.kim1503@gmail.com>
Cc: davem@davemloft.net, Jamal Hadi Salim <jhs@mojatatu.com>, jiri@resnulli.us, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	xiyou.wangcong@gmail.com, horms@kernel.org, syzkaller@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253406-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,mojatatu.com,resnulli.us,kernel.org,vger.kernel.org,redhat.com,gmail.com,googlegroups.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D880B863A3
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 5:30=E2=80=AFAM =EA=B9=80=EA=B0=95=EB=AF=BC <km.kim=
1503@gmail.com> wrote:
>
> Apologies, I set the wrong title and KASAN report. The root cause is
> out-of-bounds, not use-after-free. Please find the correct KASAN
> report below.

This is great, do you have a patch to fix the issue and get full
credit on the resolution ?

Thank you

