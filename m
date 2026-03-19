Return-Path: <netdev+bounces-269300-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDKYMZN4u2lvkgIAu9opvQ
	(envelope-from <netdev+bounces-269300-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 05:16:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6952C5DA0
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 05:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 361953061611
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 04:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B42A314A90;
	Thu, 19 Mar 2026 04:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cZE6OFPv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E252E1C6B
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 04:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773893741; cv=pass; b=X+mLhMBjXwuX4NbpWb9PnpsKWKQogK5pBbFdVxJFozgB7g59asCxJ7GSm8KyWi4to5S/TjCmKL9F8zta+qPNxUFnhX+DhTF0cwBCA9JjIxbWPMnJrY4Sd4iLe00TgQV0jQV2FHuk+UQF4V7NMxe+eRCrpveTnL/rn4+r91Vm9g8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773893741; c=relaxed/simple;
	bh=qnAsudHzHhrlLcdi9QI+7XViXfirojThS4VXlI6xXQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iT5Zn5ui2l/gr0ylBN6QxYHixe46h71P353imLyC53SI6tIu6qL7xXJ4wYFq+SHxChxGaYEfVFGEAu1YGDWEG+4ZqtBJzAs8YLAYdY7VeRp2PRva2sJIzXccTM9WPbTNPcW4NKOxJzG1nt2xOP1ORF4GV+vHBHwnEtYyJJ0SMzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cZE6OFPv; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1271195d2a7so401207c88.0
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 21:15:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773893739; cv=none;
        d=google.com; s=arc-20240605;
        b=Y9/+wjcnYvzIGTWonJj33hYrdxXybYO6ZA/0HAYiKuYP80H1G3+b78uLINayZY1gTR
         cVtob8CMR/whh+yUmvWhYQ3rxYd7ECXC54kr6NNyYsYq5tED7/ttoDg/BzGMwCPPuByc
         djXjV0OTsrYX2Ze3yIm8/znqRe2KycJPiOgtueJGd5HgbpNxX5v0twBrpqmkolC3mywB
         TaxnwPBVegmJLaEBGREsVk+bRgC+H/9JMuLAFux9yrJVdRIft28bqx1uYIxVbfLBY6Zv
         1OrGarRA3gU6dGR5IwmMFzFpo2O5w1l333Hk7xOwrd+yu0unD2SV0MSJz2N4H80+SZ/z
         YsTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qnAsudHzHhrlLcdi9QI+7XViXfirojThS4VXlI6xXQ8=;
        fh=REktz2HlE3wSLU/QEryrWJzW+rqUO6bkV7aHyJZsBsI=;
        b=OwlWiunrNAYm1XlBScy9OCy0+CVOyiUsBLL9NRQcm6HZha/e0FkAkfJEdeFtVZElKt
         7XIe+R/3YgPybUk57acxLB7mdiBGTg1DvhzbJhYGNJysdsmyrwxAFtJ045c1wQ1WzFXh
         hAxQWF86JypIISrrhi53FyVTDQjdQFO1g+mCAMYM8bOGBJCEmINn2WuU00siT1bFtmUc
         B57ec31cAE2T0oABwLA5ohc9GQUjTwCjtYNByXL89TxMILiijB42ThoOtalG34Ec+l/2
         hh9MTDIR8FR6g8atVVUQDyPX99jz3jGb0IEpx/H1045aZ/YNIDbPICHD90bwVYWa3K0G
         n3Wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773893739; x=1774498539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnAsudHzHhrlLcdi9QI+7XViXfirojThS4VXlI6xXQ8=;
        b=cZE6OFPvTcevKikLCmWSKYxeqAztDxyvPriV+sRA5KsWgT0FBiCzv9aeS6gqh7MXdj
         lBJpjL8vRau7WLp/iloNNTpnxE/mirfuadBf0B7Z1kppqYlkya0gzER/FOaJ+MrrBg7I
         nfc8zlijVY3HKeU5bWZCnY8R+Y1CDVVUFmjQMzpkie6lLLH7ZXGbo1YxFq743YvJBitk
         weAVExIU83oL/l0Q67viIRqZG1m7oD1+GrBYt4lNRJX2M4aspqvmQfWGRqm8KV6tgp4z
         Osjy0DMvESQILpFWsMaltUhHhlr4y3Ysd3Np9i79raHutHmoJB1KJYGawwOMdhOFOQl1
         +XEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773893739; x=1774498539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qnAsudHzHhrlLcdi9QI+7XViXfirojThS4VXlI6xXQ8=;
        b=bU/eGjNNZx3jDE5ht2+lx+WoWQ9mQBNm/G0MjEhZhcHvVAdZfRLBqTnoUeDeW+1yhH
         JBkbP4zJRzoorHPqP03MHNFNE7mh5aK9f7UW02f3RM7BsKZNE/2lU+M6k57r0xmF5b/K
         QYDRk+Fuf61vhsot9cfU3Nafidmo+BXnnsZ38dTpQ7Kz85wR1A/tuLQm0h3e+sl2SVRa
         QzO+SlxYzqG/Y6IbaZuVgPKr8NdnlEBUUfw/x07/hD5eZw3/sSBjN23W/djMSJUYmpDv
         tKxSI+UJD4nAu0LWt9ZvR8UjK8Uz5brOA1iELdurj41lV6189DUkbOS7o1zyQksdYqKR
         qF7g==
X-Gm-Message-State: AOJu0Yz74RCDJ2T1/tVqmHkwlqYaf4DBDYs45yDmxFMACtrCJwy2gwQf
	azcdAQtimkZicPRjr+EykREqz0ZixGKFVAmvkCf+8YbSbysABJpXp2OtJxbhVGQAtEV/11i6vep
	S34Wmqk77n/86Bb1dm56ymFinwXBKkikm0Wl8eAB4bujKMWtueW7Yn4ExyI4=
X-Gm-Gg: ATEYQzxPM79TuH7RruwAdkwdA9KD2ywvg7YOUP/ynsnOoLVvHI89bpWPP70G/SBH2MG
	l7QhATl5u1lqKTaxZAHbJ89KRfXcC8FtlGjWPVuP/lrjWx5uwqsWogG4c9F1Xu3DrKlW6ZrT5ZR
	ni84E70F61S5nSvjeeUI8EWdR4onCaJoksVBAl2QpeMtwf+s8HaRVZhBtWY9M8UE9I8YNElWop4
	FfPWuNHRH6HHcJl2Va8xG8IXIm+eEQD3UKE4/unG6ti7fD3MNpMHQkckxuGmTEMPzJpxRepJkH7
	ka34Zs/gXxPS7+avOG3xcGm+ZyqQZERGdJ77cjk=
X-Received: by 2002:a05:7022:692:b0:128:d4db:4464 with SMTP id
 a92af1059eb24-129a71602f4mr3483029c88.25.1773893738684; Wed, 18 Mar 2026
 21:15:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5ed5489ecdd05c43bd551804f3bd020ae349f3ca.1773849195.git.sd@queasysnail.net>
In-Reply-To: <5ed5489ecdd05c43bd551804f3bd020ae349f3ca.1773849195.git.sd@queasysnail.net>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 18 Mar 2026 21:15:27 -0700
X-Gm-Features: AaiRm53XDRxkSC-u1eQpLiCvBMeptee24YTqCFkNLooxbS-p3pcCSQR1B7h8e5Q
Message-ID: <CAAVpQUAfOAkOo2tFzDkoQDF3SM-k0P0O4L25kymTsh+Fw7fanw@mail.gmail.com>
Subject: Re: [PATCH net] rtnetlink: fix leak of SRCU struct in rtnl_link_register
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-269300-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2E6952C5DA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 9:15=E2=80=AFAM Sabrina Dubroca <sd@queasysnail.net=
> wrote:
>
> Commit 6b57ff21a310 ("rtnetlink: Protect link_ops by mutex.") swapped
> the EEXIST check with the init_srcu_struct, but didn't add cleanup of
> the SRCU struct we just allocated in case of error.
>
> Fixes: 6b57ff21a310 ("rtnetlink: Protect link_ops by mutex.")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks !

