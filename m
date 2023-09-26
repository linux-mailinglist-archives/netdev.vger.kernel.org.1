Return-Path: <netdev+bounces-36347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D36C17AF4F3
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 22:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id D8C001C20756
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 20:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BEC48EAD;
	Tue, 26 Sep 2023 20:21:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6D441239
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 20:21:12 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214E9121
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 13:21:09 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9ae7383b7ecso1841621866b.0
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 13:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695759667; x=1696364467; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uBd5cqpNTWtjQ2ni1Qtqh2nGe0gAlzJiOKRSOLokiSo=;
        b=A4jG7U4SImyw/2eTbgR3L/dHgBVHSnP4aYM6kM8TBpuzGX09PSCGle8+HPzUVfVIti
         3zKkvdWhWdLlShpVZ9y7YuVfXNohSKjsg46ukOcOTAVlLZyt+Pmc2yL1fxyJb9TcWJzZ
         d+l7TQ4xIW9Jag9HbAw34vjBTq0R6gmOixE+QnORQCg35Sh2B2TG0D0pPJPpbPRkDjvb
         aLzu1CCYINbvPzluxB4ulL1DhNy8GDxlnOHxb09TFZAaZiz8iJKoaaF6uSvPQSTQ8IjT
         SzOn2bKnJby5o13Edi4+jiX4VSrfJ/d51ghX7czwWVLmTRrtK7f3vTyIyObaycJ2CxYD
         IK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695759667; x=1696364467;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uBd5cqpNTWtjQ2ni1Qtqh2nGe0gAlzJiOKRSOLokiSo=;
        b=wkLcD8eJ0k5mODV0Fzc7fL85m8LWHYsvjUNlFouS/xZDNxKoTr8Mqn9PksaDB/sj46
         RQwYFIkIHfLECD4Aa4wcIF5p50LhIZmBZHqmeQqlQPAG6cdXNWIBaK1K1g0Bwj+g/gh8
         gCM3JoDQc5QSeGp0ASqPFmbC/+Yct2wCFZgTJmhrzxW53t4lNHRX3i6R4NtZtEfj5wp+
         0dvlrj9NlezogGIoz2/Is5VahjvZq9RmetNUgYBldsJ70QMzXJmy5Xbd5zmebJYOSq9u
         7jrnqGwr7/4Bv1PmMmcYLaU/xW5K7k91+WXqRQ0ocmadu88WTzR7nuUrMtIwEjQo1YIU
         R4Yg==
X-Gm-Message-State: AOJu0YynDKa+hH8TXQy6mAtJNoP/vLmoeC1JdSzqexbN1eqWdgtoxOIt
	ftkbnrnYipAdOpJX0bcw7SUmFVW13RGkLYjd3etGRTwxxBMbDHQng6ZRBA==
X-Google-Smtp-Source: AGHT+IEJZkGZ37qnAL8AT8V4Vu+ZmN5SoIZqk46GL1E+UqN8Z3lY0hClmAeYbPWyDgFh6gdK0tI9SQzebWF9XtIxb54=
X-Received: by 2002:a17:907:36c4:b0:9ae:3768:f0ce with SMTP id
 bj4-20020a17090736c400b009ae3768f0cemr5618523ejc.0.1695759667408; Tue, 26 Sep
 2023 13:21:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230921120913.566702-5-daan.j.demeyer@gmail.com>
 <20230925221241.2345534-1-jrife@google.com> <CAO8sHc=K1042abA1AVPA8Dn_cEt7-jGQgrUHSWFiUE9KXy5Chg@mail.gmail.com>
In-Reply-To: <CAO8sHc=K1042abA1AVPA8Dn_cEt7-jGQgrUHSWFiUE9KXy5Chg@mail.gmail.com>
From: Jordan Rife <jrife@google.com>
Date: Tue, 26 Sep 2023 13:20:55 -0700
Message-ID: <CADKFtnTk9mFvvm2hvb4ynHAykDw+dxtZTfDEwvoke3kCr576aw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/9] bpf: Implement cgroup sockaddr hooks for
 unix sockets
To: Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: bpf@vger.kernel.org, kernel-team@meta.com, martin.lau@linux.dev, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> That would be great! I think it makes sense to apply the same concept to unix
> sockets so insulating changes to the msg_namelen seems like the way to go.

Just sent a new version of my patch series with this change, so we'll see how
it goes.

> This is not yet allowed. We only allow changing the unix sockaddr length at the
> moment. Maybe in the future we'd want to allow changing INET6 addr lengths
> as well but currently we don't allow this.

Ack. Just curious, as I don't think it would be good to, e.g., have a connect4
hook modifying the address length for an IPv4 address.

