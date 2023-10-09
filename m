Return-Path: <netdev+bounces-39077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 203127BDCE5
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 14:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E00C81C208E1
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 12:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEC5179A4;
	Mon,  9 Oct 2023 12:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qj+3v/rD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBB2C8F8;
	Mon,  9 Oct 2023 12:53:15 +0000 (UTC)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA13C9D;
	Mon,  9 Oct 2023 05:53:12 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a21ea6baccso54650617b3.1;
        Mon, 09 Oct 2023 05:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696855992; x=1697460792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsH+1QX7hsku5ET4BmlWuuWtr+U2Xh27ghsMF+v5n9c=;
        b=Qj+3v/rDefinMDB+HmlmkCS/Cbemmz+6WH+zxwKtOn+0veSoQn+eyUfWSSTcUgeKwg
         Uefr9MQUVcz/w3O5LOLDGnvKaNSBvJbSFFMn9ydNE8ozbJp7YFp5z/9sjsOfEZIxdE04
         jHAuViahn76q+HqYUS9h2+KRmSZ08Mz7lWBA/8VY4m7/29lB+mFHdxBg8gJHqBR2j6aa
         TvuCfPg3gItd+c/PV5Bq3Uo6FSulHQ6nUYfE/IJ448S0JRxmDDRkgJ74cqgnbqpClqvr
         HPUH+qQyzP7ySF6Dif5zRzatvKX3DDn+YjY+zhi8eGYNnKP5BhgZ+5nysxHKjh5+avem
         cG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696855992; x=1697460792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsH+1QX7hsku5ET4BmlWuuWtr+U2Xh27ghsMF+v5n9c=;
        b=p7v14Hr4jNRDzb9LZzTJf3TlHJ8h/by5TGiiutMXKEkSTHSbvJa6RDYZwzHn9oRSDa
         KFp8H87oRLYDG+pX6LtRrouSHZk0UQxFmb8YqC0Al9jOphLnPuY9Tep96yGWyKXFdteD
         UQXno34Uvvjpq9tvuJUMBIkZw7vkW2Q4ymBF7nnCUNe+Je/rG2AJlWWfg+XRHaGnxYS8
         poT165H1dky7sIVCX3DWDtDsA0qgXJza4YwtJkF6iQrIBX7N2dnMunj0KO/NtiYxNKCW
         E9nEYej7uQTpsqUviP3OmiQynsVnRmOssrzTb56ueDpyAOPSzCUms03OB70Ox1/aiexe
         wyyg==
X-Gm-Message-State: AOJu0Yz5WLY+/xTTuj7fZe4DdFbYPVYv63nT6gAks0dWZofqifpqWj7U
	r0FIXpVVrrYd0fpwZjJ7+Up+bwbGRisWjMPhYeQ=
X-Google-Smtp-Source: AGHT+IGOPofh50OtRMO6gOE7TN3Wrw+Ctm2WnKWzL3gBLVfAT0ZVl+vOa/ZIJ+Vo+Yam0sPwIdK+d/lzuLx2L/S5kRo=
X-Received: by 2002:a0d:f182:0:b0:5a4:3e67:35a3 with SMTP id
 a124-20020a0df182000000b005a43e6735a3mr14879274ywf.49.1696855992056; Mon, 09
 Oct 2023 05:53:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com> <5334dc69-1604-4408-9cce-3c89bc5d7688@lunn.ch>
In-Reply-To: <5334dc69-1604-4408-9cce-3c89bc5d7688@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 9 Oct 2023 14:53:00 +0200
Message-ID: <CANiq72n6DMeXQrgOzS_+3VdgNYAmpcnneAHJnZERUQhMExg+0A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/3] Rust abstractions for network PHY drivers
To: Andrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, greg@kroah.com, tmgross@umich.edu, 
	Andrea Righi <andrea.righi@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 2:48=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> Any ideas?

That is `RETHUNK` and `X86_KERNEL_IBT`.

Since this will keep confusing people, I will make it a `depends on !`
as discussed in the past. I hope it is OK for e.g. Andrea.

Cheers,
Miguel

