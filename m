Return-Path: <netdev+bounces-51625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D0E7FB6E6
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 11:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA6F1C2122E
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 10:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3AC4D59F;
	Tue, 28 Nov 2023 10:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CAB1K3qh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CA9E6
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 02:14:43 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54b0c368d98so5491a12.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 02:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701166482; x=1701771282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/KrtIIT8sw6IeqSXh7ZD4VXnepme0DQCBOYdj1k2Kk=;
        b=CAB1K3qhQc0W2UQO4I++qWeVTRQQrNNxXiP+zrnu4L6e756YnyA+v9KTctb8azJqri
         OAibItdGBPL1IxbOb6TF366pXd1AnlEc7OSkwiMbNmMDZElljC9HfLNFM/Zic4Wx/cQ+
         YWB31YyKSykHIRPAz3Wt9/PfvsmH796pNBw81YX7ZvBgzIfJaIiAQeSuAtvZfxj2WS+H
         U5JzJQyQvv943LYY6UIfR66Y39PgZEvJ2JdCE0JKmdGCCjOyKOP7hUCPaLEuhRJlm7nG
         ELM3KwH+7mZpbtIjN6qkGFHAFnjPIGX0kr8T4t+nQLGIWGVZ8Plvdb8PvUUpt0iAOJhs
         P8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701166482; x=1701771282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/KrtIIT8sw6IeqSXh7ZD4VXnepme0DQCBOYdj1k2Kk=;
        b=nP7F7bbMwL0032Lf6yIIlEjq2pNAPA9OXaWecaRCJDxr5DoqzlLjCEu1RuFVorhykW
         YhAtTlxlui4OSTJ/8mK480yKbl7IQZAD+zW0E2dT7z5N8t8ZtAteQGc+4GeuD6xDgSn1
         sPpXLHXCZjC+Q3Vj7vo5mgLM0a56AfGysTi0zlBiXUg5S1o17Yw+WivRnl6+HH1UDU4E
         CMsRxlxfq6tY/pisstNp+a77S5J5j9k5bHVsccqjqoPsZX/niku8ri5+j3Rze0q6bjrw
         uGqBeUhV3L6DcJ6md119X3ztRSUa1oH2SRW1gJOWAXTeIeU9ZMlO2adHa98y0+KN7bn1
         Vavw==
X-Gm-Message-State: AOJu0Yycs87Y9bpMApWjoVr1XL0FH/tpElWzJc3tc6fMOBO/iBMbq2+c
	/19QnsH6H6Q4vE+ll1/EuJXqneZ/6DEpAaOGO7RrsQ==
X-Google-Smtp-Source: AGHT+IGU6d51jwtwXrGXD6ceRR/GLE9xaeXVr0z4pgEyXRBSi3Piy/WfK9h5lvhCal9bgJVx61w0pp1tkbSO3RflhLY=
X-Received: by 2002:a05:6402:2685:b0:54b:6b3f:4a86 with SMTP id
 w5-20020a056402268500b0054b6b3f4a86mr310260edd.4.1701166481856; Tue, 28 Nov
 2023 02:14:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bfb52b5103de808cda022e2d16bac6cf3ef747d6.1700780828.git.gnault@redhat.com>
In-Reply-To: <bfb52b5103de808cda022e2d16bac6cf3ef747d6.1700780828.git.gnault@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Nov 2023 11:14:28 +0100
Message-ID: <CANn89i+sqG+T7LNxXhB-KHM-c7DU2v__vEbiV1_DJV7tkuEaGg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tcp: Dump bound-only sockets in inet_diag.
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Michal Kubecek <mkubecek@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 12:11=E2=80=AFAM Guillaume Nault <gnault@redhat.com=
> wrote:
>
> Walk the hashinfo->bhash2 table so that inet_diag can dump TCP sockets
> that are bound but haven't yet called connect() or listen().
>
> This allows ss to dump bound-only TCP sockets, together with listening
> sockets (as there's no specific state for bound-only sockets). This is
> similar to the UDP behaviour for which bound-only sockets are already
> dumped by ss -lu.
>
> The code is inspired by the ->lhash2 loop. However there's no manual
> test of the source port, since this kind of filtering is already
> handled by inet_diag_bc_sk(). Also, a maximum of 16 sockets are dumped
> at a time, to avoid running with bh disabled for too long.
>
> No change is needed for ss. With an IPv4, an IPv6 and an IPv6-only
> socket, bound respectively to 40000, 64000, 60000, the result is:
>
>   $ ss -lt
>   State  Recv-Q Send-Q Local Address:Port  Peer Address:PortProcess
>   UNCONN 0      0            0.0.0.0:40000      0.0.0.0:*
>   UNCONN 0      0               [::]:60000         [::]:*
>   UNCONN 0      0                  *:64000            *:*


Hmm...   "ss -l" is supposed to only list listening sockets.

So this change might confuse some users ?

