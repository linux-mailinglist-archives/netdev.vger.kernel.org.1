Return-Path: <netdev+bounces-253139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNWqF3jEdWkKIgEAu9opvQ
	(envelope-from <netdev+bounces-253139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 08:21:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED7F7FF7F
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 08:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1859F30057B5
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 07:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762EF3BB48;
	Sun, 25 Jan 2026 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFuMAndC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157AA3EBF2D
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 07:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.194
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769325685; cv=pass; b=c7Balw9yc2Z7Vp6dj9p9BfIFJGWaSKBbfw/dJLBmX58fkS7fAUw8dCssRAFvwmCDSaSfEKyD/FSH16FBm2ykQYdzQvcOT0LE5XLyU0QkCX6Ia9H/v7ecBwNBEiKfdVnf0JzOY/2raNhZNmloC+pHk3Lj458PCDjllUcYqW0N+S8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769325685; c=relaxed/simple;
	bh=2a6/ovDrHY1rvVl5nDgWvJ+VnyVqwxyw0c1/9XVXViE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sFofo5aNS/HtN0GprB7eXNImUdZ+w2BZOBy0c5N7tiBns6ccMsfs8yOh78hn2NF/xqwAM+AICwhEq2xl2kTlfPR7qrzW9Ka3DIKPQEdy3C3RUYqlUxkcM0wa40vi1qRp3GIcEjpQDbSqXL6pdQYudVpOuBcskD7gLyqAXfLotK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFuMAndC; arc=pass smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-5029aa94f28so33794901cf.1
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 23:21:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769325683; cv=none;
        d=google.com; s=arc-20240605;
        b=B7IAMfY12/jsp4evNHV8dONsifa1atZLJr8KMXf25ghBstI5kBG5dyJ9cY5zZUFC8j
         ZIs+YVgcmjNE2I9JFbwfTpBilMg9ZitUVvtDcLwXoQ9vY+rn7NWockJvli20VvrVmXb7
         28Mi44WNCTB0xdIV/3GkwdVfAGSu8VPUvmCE6UnBHOhwuPpGnDlaR+yO1Z28oaj4qyIK
         U5IYtyGlz0GF0PuPEn7rMyzw4aQbMIHJX0eQgNWK2699d6muwrFiWWCKdMRaw6+z4F7K
         5HbgVTOXvkMMH4w6dijGUue7tzG/lygk3rTs75LVSgo4BJpXU/xNuqWtjNtdoo6ngd9k
         01wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2a6/ovDrHY1rvVl5nDgWvJ+VnyVqwxyw0c1/9XVXViE=;
        fh=xUWfZVlFXHwqz63qygUqSgGiYGk2RhtlEbVkV2nvewI=;
        b=BYh90FxzBjuAIa13hqr+NiC51Zo+oSmCFHkXk5AV4ehyBCNmh4YKD8smolSBbuKTKq
         fiWccG8AGhhkJF28rsC5TjVU0SKVftiLxY1bmwjRADhqBSzgavoOiNhqTbH1W9mzJFuV
         yLQ1+MR8wrfP2F46+mpRlcECYYWT+93MlKZ2L0/8oS1qroeh3Eb0UQKGHORoaCcMrOBf
         RmtT79bmVPpanwrwuBsKW67S/TTp3JX8NVUPLaL3OtRySuY4dfryVtcmf+fJbIyZ4TGu
         iESIt2xduxbFdTCw0wfZ0Dp8Re9BBg4Iv3tLIWydiZuSNvZ7A/gzWZg3XvutGayy0Yob
         foDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769325683; x=1769930483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2a6/ovDrHY1rvVl5nDgWvJ+VnyVqwxyw0c1/9XVXViE=;
        b=YFuMAndCdwqwuWN0hoVHWaTfJakQ2EC5fxI8T/c7FAd9YKbPKTeJyChyLy/jACXz3T
         GXUEdT+2P0NCEHNYyekD1bmm2zRmG/i/id2VMNoSjhNd5BW2c1JC5YxcS2HzrEgjaYxL
         IM4aGmJsKH9CX0vt5DxI+fFt4YytLiKU7Y9pbMNBmfG8YhSmH5UHFvC1MgyNK81nINL6
         BGsLhG4WbYoI2v1VXOO8VInq5A+et8WUxvk92ZEQCQdqajxpd+gJoDpvHDGVmwDa06Ar
         BLr6Y1XASJAZUqBVEItr9hGmEnFJTk34V3lVF2/E4uQCMDQXaHVv8VERPhDapa5uEG7j
         Hlkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769325683; x=1769930483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2a6/ovDrHY1rvVl5nDgWvJ+VnyVqwxyw0c1/9XVXViE=;
        b=VLQN5WPTcEjaY8/SU+gmhVf3cSk8aDB3uQzyuvXQHWLB/nBHDJXIcTpsOixkoji1hW
         NEa3gNnppYuKXe7iS4zOFqhyBZX3mIZgg1tRkhjHnItwvNUYWXJ8SAVopoVLucwfKMyS
         ZZBfVUMu6vwKBMZULwCvzEgz7BJe0ycAQ5v/JvDu1ep/8iAD1GlOxsLkeUrZ5MPawcAm
         7cE4hTSWpk20nnfkd7hGK6OB2RxIfeizYSeR+2BlISXg64hC4kGGfCrV4Q1Th8+nEl3+
         vA8fGVuWDuPP0j8F4XQI0kD78qQnrBnELH9CxfsSE7ggbOLZOe6QWSjPprpYBXu1tJq2
         k5zA==
X-Gm-Message-State: AOJu0YwjiFHAr7k/XUvROlfdh+ANQru96b9FOieiYYyyz9fdUpIL/p0J
	JYAplXJs9UZRIABpcd2bdsfpdCuwjQnSxmtqh+S1gckv8Y+1+EXUe9K1JrkICZUKkApGTgTDkMQ
	EGRAfAZ/MIl9JRZ2egoSkQv4y2Gg0l7aU4Gno
X-Gm-Gg: AZuq6aIgHK0wQe8lO+N9x68Tha7kyYHs+HwZvqXEBr4tYdeCW5P9d1cF4iIMsCYDGYO
	In9b8yxlxUWWaB62gn4OI8xN5iMfSECEtQs+0aEGLZdew8BG4ODKUJKRBmgi6SeazpOJWjm4bUK
	FvmtLQGd9tn0Or4BhZIYc8Dhf7kjsnJUCNZE64gXZiskQO79fqLSPQAluP8s5FaipausvAwehkc
	+qQXGbc3vmIvhFGuXTzNATC3ACcNFWZ5lLuHTm1qhFO6HAphWWJG+SjamenIHcWXq69/rdYPCSm
	o66a6O4lgq0tmCE/cv/Z6wJ5m8KSSVQbVPcS+24TyC0pwQ1IuEc4xUCw
X-Received: by 2002:a05:622a:4c:b0:4f1:c601:3ca4 with SMTP id
 d75a77b69052e-50314cb03demr11326671cf.32.1769325682964; Sat, 24 Jan 2026
 23:21:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107071146.30083-1-enelsonmoore@gmail.com> <20260109180147.GN345651@kernel.org>
In-Reply-To: <20260109180147.GN345651@kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sat, 24 Jan 2026 23:21:12 -0800
X-Gm-Features: AZwV_Qga1WBP-RSu4jAXVPDsybvnqWiIhc0cAxYyIfV3tfTV1bg3DEmaMo1-_yU
Message-ID: <CADkSEUjEobNfmnq1vZz5mr7rDs6hN43LeOk1UJ5gWW_jFFHhaQ@mail.gmail.com>
Subject: Re: [PATCH net-next] docs: 3c509: remove note about card detection
 failing with overclock
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253139-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9ED7F7FF7F
X-Rspamd-Action: no action

On Fri, Jan 9, 2026 at 10:01=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
> In any case, I think it would be worth providing a reference
> to the commit where this was fixed.
I just checked with git blame and all of the mdelay/udelay references
in the driver predate Git history.

