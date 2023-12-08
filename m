Return-Path: <netdev+bounces-55317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A10380A5D4
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 15:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE7A7B20C81
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 14:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F52E1DFF3;
	Fri,  8 Dec 2023 14:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UveSFOpO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA468E;
	Fri,  8 Dec 2023 06:42:55 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5d3758fdd2eso21099887b3.0;
        Fri, 08 Dec 2023 06:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702046575; x=1702651375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xPNBFQg9njMrtDuWdL4DSQh73kRiD7N4ngZAS6e6VE=;
        b=UveSFOpO1dtw92wB5lk68BPJPlbhYOA/IRW2zH4pb5xxA3lViReT2fv1aEWKlAH3Q1
         O7Ogvfge3lG9An6yhTKN8RbUwWA55/Sxh+Bhb2Qbomgg0uALQYgjPJk/rYh2gsR9/qau
         zpKi+UT9BzWxFrhGFRen8vW7CXJQw9YNLp2sfntEA9AWQ74HIpxR7f3fgtYPD08vxEtA
         mZI8Gwymm5bfVj1qN7nuTEY6agJpqy062JOcPP6IeMpIoyHRoIRvtpBgfuwMBR1c7lsa
         6JY2V1WfEiGVIbTVTvfPkv+8A6OvjtzvNc04HJbCy8ZoPMFWJ3QAixy2XH7b+JiB/Edd
         DKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702046575; x=1702651375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xPNBFQg9njMrtDuWdL4DSQh73kRiD7N4ngZAS6e6VE=;
        b=felNPgmeNZVfV0AKQX9Kn+m2w/zkTV4CnhmFx3bi2V9QJj+xWKx2iox2cuWcqxENL7
         05RDQt9C4SsuQmfdJ2oSmu6vb8CXfWjrwFOM7wtOWExW6GsHg1UehVWFFwWA0OfxBI/M
         bureNmADpTyeE4y+eou2hzwjEBtrb0WgbjmHiV02VuiZc7jFnIbeDPhvldZA8eks7M0s
         ETG9pq9jOiLYHdcyMC2Sffu4BHnIkXQ99sjeoTS088XAYJq4x/1h0tCJiogVnUBWf6+d
         e1q2bSDh3rKo+ZItElUFKG2AwQdAZtIEEvhtfbAwwJCoLAtTNQ66zMOV2XUraLYpkv8m
         yQIQ==
X-Gm-Message-State: AOJu0YzwTeaY1P9eN2rjSs2j/xKDWPX79kVvCrPi+ye10AogoWg1581F
	ivep20XAU0amqCfTvhxYeHw47cFnKQcYzxVikTc=
X-Google-Smtp-Source: AGHT+IF7+uwj7yNmlOZskv98AKgmhjC77Bc4mwgxhBBa2EK3EGI49BPOF7UO3fH8OQRcpg5v/fG1kAPjUB1S7mAhFD0=
X-Received: by 2002:a0d:ead0:0:b0:5d7:1941:356f with SMTP id
 t199-20020a0dead0000000b005d71941356fmr36980ywe.86.1702046574952; Fri, 08 Dec
 2023 06:42:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205011420.1246000-1-fujita.tomonori@gmail.com>
 <20231205011420.1246000-3-fujita.tomonori@gmail.com> <CXG0T2MKC8H4.2WAVL6YCX9XC7@kernel.org>
 <20231205.124407.1028275511920165940.fujita.tomonori@gmail.com>
In-Reply-To: <20231205.124407.1028275511920165940.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 8 Dec 2023 15:42:43 +0100
Message-ID: <CANiq72=-xz42yNkjujqvpWd+xM5uetVSDXrRtSFbYXEOawXqFQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 2/4] rust: net::phy add module_phy_driver macro
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: jarkko@kernel.org, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	andrew@lunn.ch, tmgross@umich.edu, benno.lossin@proton.me, wedsonaf@gmail.com, 
	aliceryhl@google.com, boqun.feng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 4:44=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> I follow Rust comment style here. Maybe I should do:
>
> s/This creates/This macro creates/

I think "Creates..." is fine, it is what we do in other files for functions=
.

> Likely `kernel::` part would be changed in the future.

Similarly, you could say "Corresponds...".

Cheers,
Miguel

