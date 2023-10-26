Return-Path: <netdev+bounces-44463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02577D80EB
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 12:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D1321C20EB8
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 10:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F31B20FC;
	Thu, 26 Oct 2023 10:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acr6TpR7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DC82D05B;
	Thu, 26 Oct 2023 10:39:59 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B4E18A;
	Thu, 26 Oct 2023 03:39:58 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6ce2b6cb933so429182a34.0;
        Thu, 26 Oct 2023 03:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698316798; x=1698921598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpRMECjgU7P8J4EiiaDlokXOgEtz9oxYmyz8gTMr3yk=;
        b=acr6TpR7bQgobnFDzXBsNy9qAqZv3eap9wE3ZvkToFonCgLgug5CelTgBqiTqpIrLB
         3qwAIN9vJ5XUq7/+7ohdCHZ7jEZVX+gTl6uKdbJ8+cQ4wpiYi3o+GJLr3JjXEF/IP43G
         flTHoeuXLEK0pekzcCUQc2HjD9PWgvp6e4PFo26b+vGn1dXqY672efIi8lHvg7vcPDky
         +chKeWL49tQa/7iVq0esthzmmiJEpv/sfy9UwlgorcwMPGfyNKaN5rb9X5zxdceIVjvh
         BhfDochHszwPpUQHzGbxEsYVYOfdXnRhQWLz5ABMEnkHBu1hH4+lFaYfvVwRwCpQGSjn
         hRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698316798; x=1698921598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CpRMECjgU7P8J4EiiaDlokXOgEtz9oxYmyz8gTMr3yk=;
        b=X0yQwCyfA26PKCz4TH31o3v52SKa/VWj8u1faHJsBJ9WZU7RXYIVMrs5h1UADeXB0g
         3gr+DAnc1+eAQq1JXaUG0WQbF20lAiycpH340KaLglM3J59jq4ZJaGY02Lu7K0wljjN5
         5Q1egAUCTElOztXqRmW136O2Gy/8VjGFojnzml5qkG4YuUK4uwIg9Tb8ydmmkm+OyfJn
         Z0kyu8g5xn7V7aCLDvCV0CMZusd6NlXO2hlNyRqOvR91NrxsSCDaJqJ4Tj/O5yOuNraa
         Vk0BYShlnXCanHejhO5aZSvLq8AOi/0HRcSwPZa8lASY6edDeJcfotzuwN6WEKqJrODz
         Kqfg==
X-Gm-Message-State: AOJu0Yye6rcp7S3ru0qgn8Cjfc4F4IhemgUZpeZ/NM3aJj0QGt1LTEeD
	tMn2kBMIM7+3wjX8brFhfMh2BtZz1aWaDuZJZD0Eb1PdwxD8wA==
X-Google-Smtp-Source: AGHT+IFf1jBHoLQkZUn8rkF3XOGkRgZP9HWSuXyKzokMQ3nd8D81mXLpIqnGn1VknnD6j9jqaMBfSvDQbCxASaxQb2s=
X-Received: by 2002:a9d:7d08:0:b0:6c4:cda6:ff3e with SMTP id
 v8-20020a9d7d08000000b006c4cda6ff3emr20818345otn.18.1698316798003; Thu, 26
 Oct 2023 03:39:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
In-Reply-To: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 26 Oct 2023 12:39:46 +0200
Message-ID: <CANiq72mktqtv2iZSiE6sKJ-gaee_KaEmziqd=a=Vp2ojA+2TPQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 0/5] Rust abstractions for network PHY drivers
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	tmgross@umich.edu, benno.lossin@proton.me, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 2:16=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> This patchset adds Rust abstractions for phylib. It doesn't fully
> cover the C APIs yet but I think that it's already useful. I implement
> two PHY drivers (Asix AX88772A PHYs and Realtek Generic FE-GE). Seems
> they work well with real hardware.

This patch series has had 8 versions in a month. It would be better to
wait more between revisions for this kind of patch series, especially
when there is discussion still going on in the previous ones and it is
a new "type" of code.

I understand you are doing it so that people can see the latest
version (and thus focus on that), and that is helpful, but sending
versions very quickly when the discussions are ongoing splits the
discussions into several versions. That makes it more confusing for
reviewers, and essentially discourages people from being able to
follow everything.

That, in turn, contributes to the problem of reviewers repeating
feedback or missing context -- which you said you did not like.

Please see https://docs.kernel.org/process/submitting-patches.html#don-t-ge=
t-discouraged-or-impatient

Thanks!

Cheers,
Miguel

