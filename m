Return-Path: <netdev+bounces-56606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE0D80F9BD
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 22:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E98282177
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 21:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C7E64CC4;
	Tue, 12 Dec 2023 21:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+eSgxEe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA17AB;
	Tue, 12 Dec 2023 13:48:51 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b9fcb3223dso3098054b6e.3;
        Tue, 12 Dec 2023 13:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702417731; x=1703022531; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9kBxEu0vCdxYr+LePyndeYizjAKEIkcRyk6dRNxawLU=;
        b=X+eSgxEenfT6erotoWWnN8Nrnzwqdqmf+VN/Ek9Vbl9WdPmiFmSpBcQuVr3vFYRFTQ
         xhk8vOIiGOTv5g9oz/Rf/C3Kj0C4nazJ4Q8K0H0+LUyayQDwcJFhV5eUOXt0XQVPG6h0
         IOOtVKT0fLRmsyzEbuBkFcl7m9vNXjgT3nV7YciTR/Zw4OMRZom1JH2qo3GWi7q9RTTc
         zNReNoJb2/tBnAr+BrbHLOuO3132b/Uufnw0gIgjXB1i1+5MXj4iSn658sqUzBMZmGIm
         3V3nhEZ/sSQYh2sNZW+4cu58SxIDmUHlxKzEY2M8IZb7/71msiQsEx82z3Y4dbNv64I6
         ZmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702417731; x=1703022531;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9kBxEu0vCdxYr+LePyndeYizjAKEIkcRyk6dRNxawLU=;
        b=lodd5CXI0pnCmMlVT5AfJWToXBk8uo8wYs8gwwTlWcvif9XaR/+E842cdd4qm+2irK
         Shr5PB5dbPIkiuzaoAPuEB5KJ94g0gap4S3HqQmLxQHZlgtR3anrbarlBoMVYiDEaGLD
         OYokHx1RqezvaUvroCHgKbCpO7AhSXqzjme/ANUT0JIzQ1Ph2HR6WH+NUfY6rc8mPGuM
         Ds7Cf+9FrsCd914sRoFUR0jLaz2WBzUqVBZMxyGq2do+JEHNPDi6XTJ2FehGDhZXNdJG
         vBLW7KlCXVLZi2iNOBDJETuYkHKLpkomE4d59pLEjJ044E0gWh70oiC0LZtCq4Tth8DX
         REdA==
X-Gm-Message-State: AOJu0YzsEEDOVjZYbEH+yPudQJLA4F3Tn3N5YTJ5nIJZtg5ciV1ctkOX
	P8mj9bxE7dqgOv0rm9yildRMLHXznnOIh6D/TyI=
X-Google-Smtp-Source: AGHT+IGf0dbxxsxdxyAG6vGPt61OFf+3pdNzC7neho9FWsMA3qKht/LKQFyvpNoAOwEnTghdEyo5MBQzOrmwe9Rr25M=
X-Received: by 2002:a05:6870:e388:b0:203:f96:d5a9 with SMTP id
 x8-20020a056870e38800b002030f96d5a9mr902602oad.41.1702417731051; Tue, 12 Dec
 2023 13:48:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211164039.83034-1-donald.hunter@gmail.com>
 <20231211164039.83034-4-donald.hunter@gmail.com> <ZXjFB90lpIQqbFtE@gmail.com>
In-Reply-To: <ZXjFB90lpIQqbFtE@gmail.com>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Tue, 12 Dec 2023 21:48:39 +0000
Message-ID: <CAD4GDZwQTWYHPq6wPPt+B=W9SFG-4Wb3NDp9Laaat7nq0jvU7Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 03/11] doc/netlink: Regenerate netlink .rst
 files if ynl-gen-rst changes
To: Breno Leitao <leitao@debian.org>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	Jacob Keller <jacob.e.keller@intel.com>, donald.hunter@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Dec 2023 at 20:39, Breno Leitao <leitao@debian.org> wrote:
>
> > +$(YNL_RST_DIR)/%.rst: $(YNL_TOOL)
> > +$(YNL_RST_DIR)/%.rst: $(YNL_YAML_DIR)/%.yaml $(YNL_TOOL)
> > +     $(YNL_TOOL) -i $< -o $@
>
> Why do you need both lines here? Isn't the last line enough?
>
>         $(YNL_RST_DIR)/%.rst: $(YNL_YAML_DIR)/%.yaml $(YNL_TOOL)

Good catch. I didn't intend to leave that first line in.

Thanks!

