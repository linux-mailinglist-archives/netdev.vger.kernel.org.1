Return-Path: <netdev+bounces-270336-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHrqL76ZwGmJJAQAu9opvQ
	(envelope-from <netdev+bounces-270336-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 02:39:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 405CF2EB850
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 02:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 743A13009B13
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 01:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219192192FA;
	Mon, 23 Mar 2026 01:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Doe7rQl+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6D0207DF7
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 01:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774229947; cv=pass; b=Gn28aFMS1E221/5uqZINfkQPQc9XSSprkksoSuRbs3Mmj87UsmOqKOfkuBK/Bz4FtHBJ0M6sWD1zXd5ncoG+L5MWH1LglF9u+AjEpEOPK/G99/aTCF/RemA/M90g0d4tXu9U75ZReSC7ta45HKEy6fwMzaGSGg6N4mY33W/N8zE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774229947; c=relaxed/simple;
	bh=cWe/PWDzr8joF6JD6nQ1XEA2RrWXW/kkJAS+Kk9qRGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+EJrrKvzuloQsT/dDmHbh4nJFrqJ7/0Puib3wZMrhzVF96/kDDiZ/ukQWYfgXYDaeY6ExrtSDUS0mJ8xtafZoli6ZNYUCAdcso7jG3ZpJsckK0E8nGhVosveTsQS21Zj95iB1EsgHZWspb06z/xLTiI3LqCQqlG2UdpyX564tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Doe7rQl+; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2c0c4194b2bso130590eec.2
        for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 18:39:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774229943; cv=none;
        d=google.com; s=arc-20240605;
        b=AEwaeXQ8C6HROXHr1ewppzVWy5N3zgaLZi6w0/WxDq+gEQtZLrVs8ZdsrSZkXP1K3d
         vl6CTaaEZWYbECJwciSlP9kUE9zTXKL7noLvpJrMQmI4PI6URrRpTA7FRALS14vovk7E
         aA5xQToLguHUgls6m+kzUEDDrsgaoJgHxfItrJ5JmEEcXJYqbFKmcmrr1MO20aOTNiqG
         AxZBs9+XCT+iqpjTTVXTZeAywdMQfemQByq/AWjbsZ5t2Js8R7PxbHMqiOAiE8nKneAU
         yVhU6z52qTC+LOTF6/j4JzrBLZjQNUEqeu7Is436lVubwTTqARxA8zyH1K3cLgf2YEov
         d7Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cWe/PWDzr8joF6JD6nQ1XEA2RrWXW/kkJAS+Kk9qRGI=;
        fh=Azy+SLOpvtNeZDYLOxZzU6VV7Dg5lvw/uqUA2EIO3MM=;
        b=BD4ZG+uWRhp6jnHhalzfyfZfzgYLybjnY/bcDnzW//CmhmKzuToteolZtY3j2F1yqr
         DmSL5yevYjCiM7HglMH2mmwPZDI5ZQoQpJcKy2x0GxJydcm3NdN4kYXdl18LjuYXzX4W
         1GHJxTv/HL4Gte84Y37Y1pzJN7tJAnDOIxw9MvnEUX9CIQqo/62PyHwEDw4IqqmVYKMq
         95vQMmUDdOG6kTChRsiV5/y1DLapenjSZNInGYtiQjMAwJBjNH3EyyiImcM8cTmFs2Vw
         A5OiW+TJUAwhsArDIvnt6W5JYacLm5LS2/SIpjxx6+AQ7sZ7TiewRPRQVswgE60NBLaj
         932A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774229943; x=1774834743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWe/PWDzr8joF6JD6nQ1XEA2RrWXW/kkJAS+Kk9qRGI=;
        b=Doe7rQl+AtVpPjUEG1oAqnqc/dKpgui3fu60NhDPcShWsiKXo7xd9lKm8e9A4jrbSx
         TjDb/iJUcr2/9vVLYkHizyoCDjV+POg8yOiGQB+ZSibO9QfuA3M+EccVNxii4nlJGhRo
         A8y/b/pUGg/nH1bSbXvsccorE3WbqdF5/Ce6Ou5IgQ1ujALaNWe41oNt5XQsGup1eRK4
         lN6U/N7pQU+wEK2Y8OIRs+2OeJajYbNZefT17kxpLSKZPOytX8PtiutcCe7vAOd0pv19
         1NlPe3N8u80G3BKnm6ZWo+FOeE4uNqQSlw6Z9t++jyVai5Fqutez8HNgieBQMn5gcRKG
         INoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774229943; x=1774834743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cWe/PWDzr8joF6JD6nQ1XEA2RrWXW/kkJAS+Kk9qRGI=;
        b=bJKmkLEJ0+KTTmHYuklHpWARQnFVUsHFbVdmgwJQEVAXiQmv5zPXlDtRUC+zO9kBdO
         YaUGFSxpyF8ynYOLH6SRDOxvIR0hiymgy6V3HRvgmyOxstRzofz17XFlaexum2F1l+lA
         cKnQazxif3uIOfpMYzbBvB1Y0Vr4eG31XDd55mWoVRSMu89CTX8lBlYJh6r5fT1GnpKq
         EFjyo5JiCxv5mKxr8DZrl2Degez+yWetaywf1xsndWylHbbEf+iGKBD4kYLOw4RUTGek
         LXGP8lfONs5pgY5MQ5FvH7pfZML1Sit403CARN2u7UpqwAkZmtKXb0cRkKcxR+Yy1Z7R
         KtfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNuBFVvWrE53dv621EeorW+p1tn24ZXYAhHr8jX9XNy+hDrBxr16o8NjXQhNGsNwfFslRGQgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkTgDEXEf0RGkzyD/7z4GdcwdCIjlwJiAF1RXgkKnuM/YSDkf2
	hGJaXnVftieTJMHB6Wqd/TP1cWdQsqLSny1LlFgZH1+wsac03zmoHLJC4S2dBfZ9W8hfHa43QWy
	ihaVab2id9oYo+yJpszUflLx4J2BFfrc=
X-Gm-Gg: ATEYQzyNm6if4nDBhOUlOwAFqwGidRkxKhyFFZfFo5aYgUFHxyL7lTEC7fHzqAqI6Ap
	OSHdzHgH1Cm/XCZsLjNu0asVXLMOX/dBynTPiYPIOj2RRrM0UAGXN7G8NY71mCUFP5uvcw5zVgJ
	VYWWvy60UxVH+lBNTn959e4uoGSJbVO2p9+xIdlv0NEOYsEgi7bmuCZK6OseZlCq68QidoAX+JY
	CEWFzZIjfzJFc52al68n+5F0zdPHNXZppj8e+cYp4Ieg60rPzLozVTiZSyzOqxWjzqdiUHuWrUP
	6TXi9QRLgeqwrnZQoVx/LrlTomUu/v07By9pF2xedLUwCkWAE91ez7hsBMl2qHmYjqP9OImhCXn
	p2CXxzZus+IkXIExuFbBhzvo=
X-Received: by 2002:a05:693c:3118:b0:2c0:fec3:fd2b with SMTP id
 5a478bee46e88-2c10973f6e7mr1912078eec.5.1774229943149; Sun, 22 Mar 2026
 18:39:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319121653.2975748-1-gary@kernel.org> <20260319121653.2975748-5-gary@kernel.org>
 <CANiq72kZH-AX=QQz2V+qCfVzMsUEAPan=o1E=OZOAnivj3L3HQ@mail.gmail.com> <DH9RDC77E3NE.3F8BURMZ8INBX@nvidia.com>
In-Reply-To: <DH9RDC77E3NE.3F8BURMZ8INBX@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 23 Mar 2026 02:38:49 +0100
X-Gm-Features: AQROBzAdgpVg6NMG5khS7OAHwybEFX4tptApRBIZ_6EE7KPQ0oZWmoN7Dzb4nwM
Message-ID: <CANiq72knM0_w_eHbu1qV2Ps8KbST6KcAZRtTH9FEd_5sRMqWdQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] rust: make `build_assert` module the home of
 related macros
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Gary Guo <gary@garyguo.net>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Tamir Duberstein <tamird@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Yury Norov <yury.norov@gmail.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Yury Norov <ynorov@nvidia.com>, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270336-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[garyguo.net,gmail.com,kernel.org,protonmail.com,google.com,umich.edu,ffwll.ch,collabora.com,arm.com,infradead.org,redhat.com,nvidia.com,vger.kernel.org,lists.freedesktop.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 405CF2EB850
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 2:08=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>
>
> (sorry, assumed my Reviewed-by carried an implicit ack as well)

Ah, I saw your tag for #2 and #3, but not #4 (nor #1).

Did I miss it/them?

Thanks!

Cheers,
Miguel

