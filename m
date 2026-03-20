Return-Path: <netdev+bounces-270004-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFn0HU6IvWnQ+gIAu9opvQ
	(envelope-from <netdev+bounces-270004-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:47:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D28792DEE42
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6093030541E5
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 17:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5253D333D;
	Fri, 20 Mar 2026 17:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hY53LZ26"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C84A3D6CAB
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 17:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774028637; cv=pass; b=a6dn+eHUEhRNjqjCWlun5i5fsapnaiFZEDzEGs61+X/0FAyAr1+HDP/xhcy/a3FUE5mA3ZnPy14YdeyKXbMM6ns333GQAtQW0PuGR1gwiz7XZt+HFyDVx0ILvUViAGqNV6hnSWtiwXUTkMa+EYtfiOzOCmXqqm1qOMbVhIEgkiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774028637; c=relaxed/simple;
	bh=xdQJRwjK/sV/0zyDr7fhSs57NkGs44YTnOiMeU8wh3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a8iuJJ5G4RjbDSUfawyBEnuRccVfFc6UtGQQS0BP/R7WieU/E7ta2sFT9HIfLuCQSvTzW6D9L3gOOdfgopYuiwR9yxD/wIraWKA2HRKLT0xXcpixgxq0DV6wr4LuMKio4MUQ4RM6915F4cvN0ppVXMDzpkfVjSGGNtYtoFUzcK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hY53LZ26; arc=pass smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5637886c92aso435557e0c.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 10:43:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774028634; cv=none;
        d=google.com; s=arc-20240605;
        b=F+hiprzVgNB0VoSlvFMjZ0ufx9upx4Rvnwld9i+UuDHoCeUHNMCy1fjAXbM5N8dv53
         6F2yCHz0vKlZ2RfnVYlpDvYwxDhWnbzzp3GU5i/Mw+eJn3t8c6UrTNDzwC3Ft/b8eJJr
         JsYp9zvbRE5r/C0oVUR/BPficCo782E9BPJJVASTw0STokta/Mg/qffUBkPAIxiMVIwQ
         UTqUeuRUyLqGvTwedqews7OIsq8Ak8LaHAsMvEKGTHKZKIRK5aGaYsyPGUYuvr60PORL
         4mbrFup+Hyud7XCg44BnUFGLuBnyL6XOflA50dfRcqmfKRSeXiQ8NTvF8tAN3ScZcYWk
         uCQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xdQJRwjK/sV/0zyDr7fhSs57NkGs44YTnOiMeU8wh3o=;
        fh=LbVDaYNhCVrPHuJfS48ypcY0czEJlpTHioSbUWDECsw=;
        b=XHdO2y37n/kttiLWHLmUZ9AhVo9RLt1E8Par8FS+vuvY++CX4jF66CrUeZGt/c46yJ
         Iu9hbQYTR/gBKMbBHFhuAvkbI4ijS+/P9YmhzWUwCer+Q1JqcJGF+bFVIyG0DuzR2RAf
         RSn/NtGR1MspzxKsN0PpRDtg/Nsb7SJKBmsyud4pSV7gor0fU+YveKblmSyKchAdNMP6
         KlGqGbdS9TvlOLt1qJfkhSnLR0BqZ6r0ufFbXZtFgBq5ycGzpIovhyr0CZTp76bjRmnB
         CsyInAeEkiRi5fH3Fs6KEI0sidAnwbdw2jwKkfQPQwv+NCBSMPKTadUBWWYFGm6GhMim
         4CWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774028634; x=1774633434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdQJRwjK/sV/0zyDr7fhSs57NkGs44YTnOiMeU8wh3o=;
        b=hY53LZ26rjXa+Z/Yf9iL4Del9b2cbysT96iSkCNgX5fTpKoMEHYQu57m4HvrVU5BLM
         JYql8f3LMpgOM1Ocek3ZD7TF4VjnBRPnNpjStViOmGSnvc7LZ3xBsnqNkgZ3neLe8C+B
         E9KbTp5PAW8qmbYBg5eF9qy9C1EWpa5FffhJh+xRlLb76QaBwDOliBMQZ3Je+EBwOM/3
         gCbDIfYpwtHeWmr2tmQL/kii1mlrjfl6OBN5MNKQmKRvwaWrdT0hpXXe3UaOtZB5Ng9A
         Hpu7OsSiKWLOEW6v86gIbcLVOt3pErwt+ecUF4G3lMQk22nRYpZoluVt2O+pips53cuU
         yjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774028634; x=1774633434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xdQJRwjK/sV/0zyDr7fhSs57NkGs44YTnOiMeU8wh3o=;
        b=ZbA4Z1YBzL/pefXpWoE2R0WyLFl7x/MG+/7XbzerI3838EenZo6t/L/40AZRKkb6t3
         5b0B0up89eIWeISwJPYlvHzRq+b7Xc/nlqHDTL3UPrfZV5szGdrjMXkNDpxa+/CWRU25
         Srb0pUeMq43WK2VVi3n5kho5BxuOtsjIuprMRWVpAS3FbU8MK4VD5VU4a5zYMS/TzDFo
         iLmpPk1R+75TIEE6bUYz3QSPLXcTi6icbrxOfAW0zqsOyOLbszH+5PDNvrIwssldm1Rc
         WfNLev6TCOFIZkbWmDEQK1IuPH+/bwVObpiRgXGagvOo0A5Styu6zMiOl2svD7WUOQhf
         JEkA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ+UOnN+ocS++9dnMR5WAYrxQmSGivfYRj+GRVdCHluibOjk0E9PRBjSm0KEJRX8Uv3kMOaYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiX9SqUVC7xlcskX5v0He9g7d6kKEeNuxa4QAYnDqkPAkASKF7
	GH/IQ6uJUUgs6fpbAfWbD7EKsjDN8GyFEndGF3Q4wJl2Y1tIVJ+FrOe60l1QwSVfHbaGxK57mnM
	2kmqBf1CJUFLObEiWrhwEgSjDAIYII+8=
X-Gm-Gg: ATEYQzwbSQKxc5FkCPz08u8QuHA6qdggQ39/Wjb4esStKyWf9Z+s1Ba+qPaQ7ENsKNt
	k+hi3nNhjjDAdszdVKzdGzNchiPdwy+3Rqryq/N7U71WUgFWuRKAwdAI2gUzFGGC48gsVHMY9Ou
	sO6tYzvx+bDV349vgQpr3+swHW8zgU6OQ1qKbIHBuMMgyhBUIdPZIEmAvjUd4YLcs+dlGhGdEQR
	DLnrK+BHggm2OsPPBqlHwERfT6B/+gwpfc+uQdz4Zt1LUWiVvqLVPB160HLNiAmnUdOrQVcuG1p
	75qid9o=
X-Received: by 2002:a05:6122:169f:b0:56c:c71a:e09a with SMTP id
 71dfb90a1353d-56cde43930emr1914893e0c.14.1774028634104; Fri, 20 Mar 2026
 10:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319141846.78222-1-seanwascoding@gmail.com> <ab04wi3x3JNVbvPm@black.igk.intel.com>
In-Reply-To: <ab04wi3x3JNVbvPm@black.igk.intel.com>
From: Sean Chang <seanwascoding@gmail.com>
Date: Sat, 21 Mar 2026 01:43:42 +0800
X-Gm-Features: AaiRm53AJV5D34Vu-3dquoTMOhJs2DUTyrNhZHGy1pa8coMdPVtsQQtp52EPLFs
Message-ID: <CAAb=EJUQtj08BjbzeovG2dHBfwb5vgza+HdM=ck-bn9n9Ha0BA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] sunrpc/nfs: cleanup redundant debug checks and
 refactor macros
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Chuck Lever <chuck.lever@oracle.com>, 
	David Laight <david.laight.linux@gmail.com>, Anna Schumaker <anna@kernel.org>, netdev@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270004-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.584];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D28792DEE42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 8:08=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Mar 19, 2026 at 10:18:43PM +0800, Sean Chang wrote:
> > This series cleans up redundant IS_ENABLED(CONFIG_SUNRPC_DEBUG) guards
> > across sunrpc, nfsd, and lockd, as these checks are already handled
> > within the dprintk macros.
> >
> > Additionally, it refactors the nfs_errorf() macros into a safer
> > do-while(0) pattern and removes unused nfs_warnf() macros to improve
> > code maintainability.
>
> Shall we also revert the commit ebae102897e7 ("nfsd: Mark variable
> __maybe_unused to avoid W=3D1 build break") as it seems related to
> dprintk() issues?
>

That's a great catch. I've verified that with the new dprintk() refactoring=
,
those __maybe_unused attributes are indeed redundant. I will include a
new patch in v4 to remove them and properly credit the cleanup. Thanks!

Best Regards,
Sean

