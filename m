Return-Path: <netdev+bounces-21079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0847624BF
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 23:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04967281A7D
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 21:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1166826B9F;
	Tue, 25 Jul 2023 21:48:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0621226B83
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 21:48:20 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DA310D1
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 14:48:19 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31438512cafso5512908f8f.2
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 14:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690321698; x=1690926498;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tlnn8xplmXgJVCr1fUgmo3rb2d5rmM8oukZt8jKD3QU=;
        b=Ijt9fDt6ZVnnGM8PrDCVOpqdOJBSh0AeTAas4W8OxHWRaeLH/v2VKshh30FSmc5bMr
         +LB3NyvHF7zJXr7Xw9DZwAPueVBrLSKNM2NI30E65tYdyqVUdv5UApvtoSySHa+Mj665
         u478kznnz78zXCvWXMynNmNUKLyo3LeuQK0P+FEFY1QH0YwI2oQHx4RbwM9eCd2lhCxv
         0oHRw+ox74nrPoEmIv2JdDGNOB05lriP1zMQtfQki2VmWy94VIVWg+LijksUSHQ7a1ub
         OjDioDkaaiskOdR1QJIa4uV6MKIhdTlTHr/BQb1Ro6MmqKD/uOMn2o7P2AmFInuv+THu
         Rz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690321698; x=1690926498;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tlnn8xplmXgJVCr1fUgmo3rb2d5rmM8oukZt8jKD3QU=;
        b=OsaUGu087rfbJuqtZvvS5jTZD576372OeD5QEW+KqAoa8Vg7FCZQhJ/PKyO44XEtKr
         35yjrJKFpBA81DEe/tc18mUfKM7BO5ZtFQ2Tmy3IhdNqXtcgiUESTsMlwVxS8DTw8Uc2
         JKDbf+bJkGdHbVI/HsuHfoz9P4C5PIPLR6a3vRJtm8xVt9FbuTzaG+mKXQUWWfqk7hLl
         F0mkYAdyqRIP/8PIQrsFrYc34onK6AHJfgGqWutgC4n/3yoAZt4kDDOmpQMa45xCaY3S
         5b5wDd9xLzHijBqUWJs0zpdpqYOc8sfq0jXEM41Zy/WtBKhLYZSzBDWNjzKvAblEWTqL
         QESA==
X-Gm-Message-State: ABy/qLZYzcy4/LqPAeKr+id0IyKIh7kVA+nexY1FYn0HxFk5DkYvt2m7
	zAHULNkOCjIjMnbPqFFMQsI4aUXRc6c=
X-Google-Smtp-Source: APBJJlGuKI6irzHhkUMyNiYs2zC6DMziNJHZlTedjZ68EUt8RQzBeq2N8uxZnKUOSG9Fe4axxGWvfg==
X-Received: by 2002:a5d:69c5:0:b0:315:9fb7:bd9 with SMTP id s5-20020a5d69c5000000b003159fb70bd9mr12467wrw.69.1690321697723;
        Tue, 25 Jul 2023 14:48:17 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id t2-20020adfeb82000000b0031759e6b43fsm9765521wrn.39.2023.07.25.14.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 14:48:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Jul 2023 23:48:16 +0200
Message-Id: <CUBL17I9Z3W5.1XR1LVI9CRDDU@syracuse>
Cc: <netdev@vger.kernel.org>
Subject: Re: [iproute2] bridge: link: allow filtering on bridge name
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
X-Mailer: aerc 0.15.1
References: <20230725092242.3752387-1-nico.escande@gmail.com>
 <20230725093725.6d52cc03@hermes.local>
In-Reply-To: <20230725093725.6d52cc03@hermes.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue Jul 25, 2023 at 6:37 PM CEST, Stephen Hemminger wrote:
> On Tue, 25 Jul 2023 11:22:42 +0200
> Nicolas Escande <nico.escande@gmail.com> wrote:
>
> > When using 'brige link show' we can either dump all links enslaved to a=
ny bridge
> > (called without arg ) or display a single link (called with dev arg).
> > However there is no way to dummp all links of a single bridge.
> >=20
> > To do so, this adds new optional 'master XXX' arg to 'bridge link show'=
 command.
> > usage: bridge link show master br0
> >=20
> > Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
>
> Looks good to me, but we really need to address removing the term master
> from bridge utility.

If you have a better term I can respin it.
But the thing is 'master' is still the most widely used and understood word=
 when
it comes to bridge terminology. And as you said we have it in the output of=
 many
'ip' and 'bridge' commands, that why IMHO it's the term we should use for n=
ow...

On another note, there is a slight indentation problem in the new if in
print_linkinfo(), if that can be corrected when the patch gets picked up th=
at
would be perfect, otherwise I can send a v2.

