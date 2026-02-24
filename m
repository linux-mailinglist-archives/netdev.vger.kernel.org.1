Return-Path: <netdev+bounces-260620-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FFKC+LlnWlDSgQAu9opvQ
	(envelope-from <netdev+bounces-260620-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:54:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C597D18AC9E
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0AC2E3038008
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32183A7F5F;
	Tue, 24 Feb 2026 17:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTfUyfrw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0103A1E95
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771955679; cv=pass; b=QUboiRZ6v+y2DI1NBEhwANMCcpZryeRYIt5RTqQaRpJUfituXSL/7XjZNEuDrCcbuUR1PD2gG9Y/ZlvGRM2zTKnvls4Q84OOdorg7Kxchokh+kVr0ZDqC9Xw0dERaIjtZm4+hR/CxfB4CQPX1w1vJ9t6Q9u2zMmn6Ci5gPzSncE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771955679; c=relaxed/simple;
	bh=AbCHyk4rVeTnfeUk96ZMwoOeBaihiTpGNh+iPJyOkGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CnAfg95BQaIJhkljNKkqKaXSAZG9ncAkmn7Rj5kDFnhS63zwgaVy7DB7zsIOHh8LVTA0GlGvj+p1uGjfVNNdDCJ/Dp0Dno7rUX3oFo+uc2Mg5epBOELT824P/TO0B829GNJ1FjDsD+CAxiLaBzCYIrkVZeU28iXcu8sbgywHw3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTfUyfrw; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-127337e3870so363714c88.2
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 09:54:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771955678; cv=none;
        d=google.com; s=arc-20240605;
        b=lymGma2/8WmutnvFaWDAtI3ITq8HaoObFXQoKxWPx0FLs57a5Q6zvf4sPH3rE3Z9hU
         RtXlppImrOqpwbZ2+Vunz8lLAaODrr3ZMzOd9ER5f6F1ET3ktUxNXQQ6p86qkof/OgOP
         BcnQIPfIVrtphfJd/0+n97vvAPox73HxSLTLQMy2JBdnT8IY8CeMG82ncuDAIjj8+KNx
         q6VyehILr4HzMMBLbxJQBHC9BKMCd5QqPQkNLC8AEysWlSNbH93S1g0IEIZKDn9uHZX7
         JXgYO1oyjogyvruIeI153wkMQgOH4uMIer3Hk/nGgIH5pe8FOWHN1zL5M1FAkNbPNfRw
         CHhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ah0AfPxyqE9MAeo8/B/PGijqvIRNE/+AWXO1lfvW5jg=;
        fh=Lw21qA7tXZjjV2E111JHlegMaGUYvyTBmnDrvmM83wY=;
        b=kFhEDbfTqw+GEkFIut8AHc9v9GY6+dvpqX10Id8D3CKmrFKf0WUpl8vg9g2TRl08Gv
         9xT1CHVxyQstdmzAq5fI5rJ65rHbhnn9lyWRWNB1Fw36+gY7styCB844tyTigh31Q9Cv
         DjAs6qln2ttQoPyYncdOlqHbE8QQhKPcD0+bHkGEZbN1SmjFhfQCPqoCQsP8AHAXKQaJ
         wgLIWfnCJ7kRcTpimjAvRKP09wrefNH3rHSQAw3tVLkveLWqfTYCr0nMOZ2qwsDE/MM6
         5YSY4jS1H09eUhcUuLQ5h0vxZw1KeLNkJWOhkHJr9y+c1K/bJSQ040uTdT0bhqDOyiIi
         3bGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771955678; x=1772560478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ah0AfPxyqE9MAeo8/B/PGijqvIRNE/+AWXO1lfvW5jg=;
        b=OTfUyfrwQPPKoH0p7PqdN5824QoeJVx8P09J47Runz2klejwG810BxtKiqGxn8qljf
         jymi7tkaI9bIQj7qjNzSOHR1J+WqxIZgLCtLZ2e47JG6QBDGd0i3mVES1XU1sAUfvVw7
         wP1G6dUmvlPTiRzT7fUc36Ojdj7LaFYypbh8YBZiu1H43W7Dtiq/xQnpN01Qn+OrYGp2
         i1GR+QLa2lBy1IcmhQ0nrmmJ5q/O75/uUZX+P3/4kyVyVmxA8f8cGjhJWMMmLY1HG+zn
         A7bBX949DYTynwnIQ2yq4YJ72tdr77ZZGsbCrZ8hEEhxylPTofhMj9cWgGO8gOOiBegS
         HNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771955678; x=1772560478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ah0AfPxyqE9MAeo8/B/PGijqvIRNE/+AWXO1lfvW5jg=;
        b=IMB/BfSlFkugEWiUwEvmOwNc9Xzjax1NxPqfQJRGUlKpM8DXd9NEd3eNnZXfPOQ6vk
         U9y8MkViVKjxSxvJpCUP6byEdGLdbPG9FxNvUDcjpPAQNls6Q0A5iDQINZlP9CrD68aQ
         Em3jIilBS73eLYIyI5AmB4+GrR/zaLF3c9s4rdQVsMzUFYA5R3ZSN7qrF+KGv+Gfn1f6
         VemQQlsd+cUt20KSdzuGgYSjKaAKVrbcMHzDcIUfnoKOflXP9MiRYuSrDYKiDKCvefNh
         KSItVD8tlEBei1d5nsnQR5YLMceT0zpEN9FiAV1RgrwsUH+Toerl9sp72tHZj8FXo5Tv
         jSbA==
X-Forwarded-Encrypted: i=1; AJvYcCVsmps0+LCyg7Qo8kAEa6XOZWpN7GbRu/g8dRnDQbH7bPFdaJAy8hjcOBFFYfDeMX4K6LI/J/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP9SZgUzRVAWSBfcuTx4lbwzhvZ63Zi4Yp/xWitzG221Fx9qNy
	yZNZNfDV4BpUSo5KhLuzRh5mVY5tnnoPqjhaHNZz/eJhSixQsmDz7COhtuyIsvIOiFntdynV2eZ
	dAOc9QX+jzLNXrfST8yKGHyywAayDfNQ=
X-Gm-Gg: ATEYQzxreazx8RucVflifl6Htd3pVr/DPTZxCEpZ24/GumktMmax9Pwt112n3GZQEHe
	D4sgoUwOpNNVOoRWGAqRk8LgkYF5MQTZbDNyFEcs8KAzUftPX091HJwqN6tOXqQYnm0NTD03hV+
	iXWACHv8INxpldi8WQErjsIYNuuPi1iaVU5i1Uf/7SKkOZYTK5VbBH0/8A+iXqm+v43lRmcy1MF
	CPUSf7X0UQJHPpZiv8HdcUtgB6nTa+JFAGMoYNv5sVBfYQ1WJ6lZKWPsrZUzCk9BKvD+HeiQ7CX
	TuPN6M0Lt3QsGz/XLbAODuDo+cCraRtzRb0GMpUFarNA4amuQXG+OdPQQSBwB/CzLJeworWhSDC
	kzZCmpHb6vzM1czDq5pWVkjInIVHc
X-Received: by 2002:a05:7300:3f06:b0:2bd:a4d0:a9f0 with SMTP id
 5a478bee46e88-2bda4d0aa9dmr747822eec.7.1771955677644; Tue, 24 Feb 2026
 09:54:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224043211.1747-1-iprintercanon@gmail.com>
 <20260224164926.1760-1-iprintercanon@gmail.com> <20260224164926.1760-3-iprintercanon@gmail.com>
 <CAC62b0xq8vg4njbcvR9JLvW+o--UnNHEGNVz-+Uxa90d16j80A@mail.gmail.com>
In-Reply-To: <CAC62b0xq8vg4njbcvR9JLvW+o--UnNHEGNVz-+Uxa90d16j80A@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 24 Feb 2026 18:54:24 +0100
X-Gm-Features: AaiRm50Y6UwuGIeNQC3M-fh0wmvHNBVWwpGd8K9JL6tfiKZjv5ETwCQ0J_5qf3k
Message-ID: <CANiq72kRoHsLx7GSrRq-OP-mz6Y9nru8UMp4dcvdmNJasGZcuw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] net: phy: add Rust reference driver for ET1011C
To: =?UTF-8?B?0J/RgNC40L3RgtC10YAg0J/RgNC40L3RgtC10YDQvtCy?= <iprintercanon@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Trevor Gross <tmgross@umich.edu>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Miguel Ojeda <ojeda@kernel.org>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260620-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,umich.edu,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,zulipchat.com:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C597D18AC9E
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 6:04=E2=80=AFPM =D0=9F=D1=80=D0=B8=D0=BD=D1=82=D0=
=B5=D1=80 =D0=9F=D1=80=D0=B8=D0=BD=D1=82=D0=B5=D1=80=D0=BE=D0=B2
<iprintercanon@gmail.com> wrote:
>
> Thank you for the feedback, Miguel. You raise a fair point.
>
>   Honestly, the new abstraction here (speed() getter) is quite minor --
>   it just reads a struct field. The driver itself doesn't bootstrap
>   anything significant beyond what ax88796b_rust already covers.
>
>   I'm looking to contribute to Rust in the kernel and started with PHY
>   drivers because the abstraction is well established. But I understand
>   now that duplicating C drivers isn't the goal.
>
>   Could you point me toward areas where Rust work would be most
>   valuable? I'm happy to work on new abstractions or drivers that
>   actually need bootstrapping, rather than adding another reference
>   driver to an area that's already covered.

To clarify, if the netdev maintainers want to have more reference
drivers, it is up to them, i.e. please do not feel discouraged by what
I said. :) I just thought I should mention it in case there was some
confusion.

Regarding new drivers, if you want to work around networking, then
probably the maintainers can tell you what is needed. In general, I
would suggest looking for hardware that is unsupported currently --
that is usually way easier to justify and land, and there is no
concern about duplication (and possibly arch support is not a worry
too, since there is no other driver anyway).

Regarding new abstractions or other kinds of work, you may want to
look into existing driver's lists like:

  - https://docs.kernel.org/next/gpu/nova/core/todo.html
  - https://gitlab.freedesktop.org/panfrost/linux/-/issues/?label_name%5B%5=
D=3Dtyr

We have also threads in Zulip about looking for things to work on --
in case you haven't seen them, you may want to take a look at e.g.

  https://rust-for-linux.zulipchat.com/#narrow/channel/291565-Help/topic/Lo=
oking.20for.20open.20issue

Finally, you probably know this, but you can always help not just by
writing code, but by reviewing patches and testing them -- that is
very needed, gets you credit in the Git log, and by doing so you will
likely realize what other things you could work on around the same
areas you start to review.

I hope that helps!

Cheers,
Miguel

