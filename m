Return-Path: <netdev+bounces-47002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EACB27E792C
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 07:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C10FB20F6B
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 06:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1571568E;
	Fri, 10 Nov 2023 06:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhZWQSZO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE70463B4
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 06:21:23 +0000 (UTC)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67B16A75
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 22:21:22 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-582050ce2d8so58411eaf.0
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 22:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699597282; x=1700202082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lEIvjFyRDQP4zq3EdwUgohnfZtLNsKhlPoQ3PJmh3pU=;
        b=JhZWQSZOWp7i1YPV0XawEiqzNSgND1pTFWU54kpxjqqNRyv+q63UjMIFADRKC2GXKj
         3OotYOBw7iyldorEuIgLGcjOaq3vnUWIRxwu4wjZlrnOw9+m+4YTU2eVBukD6NKFDd2A
         9Ua5GXJNMz+1JKGMMm5nUK/tvFX2/2ISa7hdBxKKjDC4hvM82VFiKEeVm5R2O/BspZdV
         H2R8FhZUwWCpIgKKyOZGqMEUJzimWsDutfuNCK7FRaYkkUNWJHdlYzBvrzSJbYKxKCyc
         BWVW9xGjUcaFpO0IOnV3fx/yH2rUEYugZujJvyjNWCzFEZS17tojj4IErdbSFvafYNZH
         8xTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699597282; x=1700202082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEIvjFyRDQP4zq3EdwUgohnfZtLNsKhlPoQ3PJmh3pU=;
        b=DG81a5/bhoH5rByHRLRZyxYTwco/UYCblUNrdYZbFqPsUaM/odnB+UUrnSg/ONXBB6
         BGS39IwR1hAG78Zf56hUI4Eh7ioGjjasqImE9nCPRrF5+3X1xLrhV9qJZRWxNQ7jvdB/
         KGh5192jPc6GlMvkJKZQhrKo5NJmtc0IQ76F2M5OX7hcPH3dZtWI1RmyDtltPTB8Ms5z
         F0WrF1Mtab7lQXYju6HWYgL3idWuc6bcksBWT2U38pnp/j0rKPJ+XAwoNGy+b/SVeabs
         pGE5ydX+aLh3u7YEQwRj8m8ok8Y2AxUkMMtuPK2JUPup+UsMunAwtrMdZ2gXWo2tT290
         REqA==
X-Gm-Message-State: AOJu0Ywjta/b0zNCQ8MxsciDqwIafPB76KrXpG9RueErpDMJjOcfIfnk
	w8A99Hu/u3RMh66ZcJMPbMs7O4I1w88=
X-Google-Smtp-Source: AGHT+IGtfpbqNts92fTYFrHMVyH3XqjHwb3TQcurBh/tg0IydALbASnMlIIYjQ8++QMZ4YikqtBGtQ==
X-Received: by 2002:a05:6a00:6702:b0:6c4:dbb5:a340 with SMTP id hm2-20020a056a00670200b006c4dbb5a340mr628913pfb.3.1699590216919;
        Thu, 09 Nov 2023 20:23:36 -0800 (PST)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id a23-20020aa78657000000b0069ea08a2a99sm11492164pfo.211.2023.11.09.20.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 20:23:36 -0800 (PST)
Date: Thu, 9 Nov 2023 20:23:34 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net] ptp: annotate data-race around q->head and q->tail
Message-ID: <ZU2wRnF_w-cEIUK2@hoboy.vegasvil.org>
References: <20231109174859.3995880-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109174859.3995880-1-edumazet@google.com>

On Thu, Nov 09, 2023 at 05:48:59PM +0000, Eric Dumazet wrote:
> As I was working on a syzbot report, I found that KCSAN would
> probably complain that reading q->head or q->tail without
> barriers could lead to invalid results.
> 
> Add corresponding READ_ONCE() and WRITE_ONCE() to avoid
> load-store tearing.

Acked-by: Richard Cochran <richardcochran@gmail.com>

