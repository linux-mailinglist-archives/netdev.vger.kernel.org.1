Return-Path: <netdev+bounces-43004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D6B7D0FBA
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 14:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7829928258A
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95D212E5E;
	Fri, 20 Oct 2023 12:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwKv4N8u"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CE21A709;
	Fri, 20 Oct 2023 12:35:49 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D66193;
	Fri, 20 Oct 2023 05:35:48 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a7b3d33663so8510637b3.3;
        Fri, 20 Oct 2023 05:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697805347; x=1698410147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7shv5STIzpqW9EtG6um2vXUADk0meBVxAG9lpqEl0o=;
        b=WwKv4N8uYHHkraqnusTECsIwkG+6qYirobI/z1IjhqmEpsU5raNkmUSTGkioAv1gOi
         ZAMliqHH/a9SqBGETsUt88aHOhWfWWr4Jyl8ZougqntLQG9cW/ehUB9oHtYjEor6TCQt
         uB3Oioqe5nHsvebVmwy3+sSDdDveDyAcRbbh3Vu252nNBKFDhVMTj45ULZmSm9Yo1eFE
         t9gTAjnMp+J9CQEDJO6GhNqeYcGtyOlWAH6UdhQOPZDfrrDi0XkUpCm0LDUTf3/lgYoJ
         WCVocT7n9fa8oh5c0fXT2g3584Ul9fiZnA1aYI3ynVdExiRT1hgT6ItVrmJuWpi+0Z4W
         FwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697805347; x=1698410147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7shv5STIzpqW9EtG6um2vXUADk0meBVxAG9lpqEl0o=;
        b=hmf/zVnTfW4iLUfNYLBgS8HYWljanFXIS4gzZ2qcpAeQ4qY976/g9rPEXMK/ih9MHy
         H7RHp6maSdeV+LjVrRHR/elnqmpwdYJGADMapJCXoab3oaWr8V6ijCuh8fvLEsiMgPCV
         tfhFXZed1YWQeX0roeuOcEH7cw0h3fsyFDlnXjSMvCrj6WwVkaSPoSRPmSoNSb+UDNq8
         t10uNZ8kN1DTvdYu9RkYv1Hu8csH/WYWw3S9FhKETZu9jQyf6+vUSMowmJLnyPotdKN/
         irNu4lqXYAMEKlFiPJAp4NAGUO116PUXukpXFN9sZoLrw313+lEY1kxXdOwiJ1jnvYew
         SWpw==
X-Gm-Message-State: AOJu0YycomnSzB1ibqfpxgijHgIP5Ti8FicRXZQsutXEVJEx7gYx803y
	vGWy2ekkhhUlgh8kIKoCVEq5PGUlhffIkmfZ9Rc=
X-Google-Smtp-Source: AGHT+IFh6viXhmVWeZA6Sc+0WyxiJh7dBqugL8wHCk7gEmjAfUfW+DgzvSYdI4Pd4kdZN97mfCdFTqsBvE88kS/Ja2k=
X-Received: by 2002:a0d:f646:0:b0:5a4:3e67:35a3 with SMTP id
 g67-20020a0df646000000b005a43e6735a3mr1587123ywf.49.1697805347140; Fri, 20
 Oct 2023 05:35:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231017113014.3492773-1-fujita.tomonori@gmail.com>
 <20231017113014.3492773-4-fujita.tomonori@gmail.com> <871qdpikq9.fsf@metaspace.dk>
 <CANiq72kWu-zNbhYxvcM7TVFLOEoRczK434J2t4rLhU31AMWAwQ@mail.gmail.com>
In-Reply-To: <CANiq72kWu-zNbhYxvcM7TVFLOEoRczK434J2t4rLhU31AMWAwQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 20 Oct 2023 14:35:36 +0200
Message-ID: <CANiq72nC2t=Xt1_a6JGQsd9CUtt_zB1S5syZ8nWu+s8a=XhRrw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/5] WIP rust: add second `bindgen` pass for
 enum exhaustiveness checking
To: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu, 
	boqun.feng@gmail.com, wedsonaf@gmail.com, benno.lossin@proton.me, 
	greg@kroah.com, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 2:34=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Please change:
>
> -        --crate-name enum_check $(obj)/bindings/bindings_enum_check.rs
> +        --crate-name enum_check
> $(srctree)/$(src)/bindings/bindings_enum_check.rs

...without the email wrapping.

Cheers,
Miguel

