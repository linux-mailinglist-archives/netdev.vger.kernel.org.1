Return-Path: <netdev+bounces-59661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7256C81BA14
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 16:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112421F257A7
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 15:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05F141A85;
	Thu, 21 Dec 2023 15:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSppce2F"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37859360AE
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703170855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q7VUsOfjQEYM1o3IuDpjOFUeqd7/I/k1ZAPo49Dkm68=;
	b=XSppce2FIL4Q7GmRkbRkcY+O3S08RRLmfcPR/rkACJuXkX/39kX8fe1975X0AgldvgxF8D
	MFSjIN4c2lQHjzoeFq7wAeNt45oQm88Ttr3r++SbmULMsZtArky9nN9ESbNqY0aLnsBnZs
	bkXuy7DcSEBF2pYw8wMoccmLaKYk0GU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-t0SvrmkHPE6qo8GhBQzkyg-1; Thu, 21 Dec 2023 10:00:52 -0500
X-MC-Unique: t0SvrmkHPE6qo8GhBQzkyg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a1fae8cca5bso13575066b.1
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 07:00:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703170851; x=1703775651;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q7VUsOfjQEYM1o3IuDpjOFUeqd7/I/k1ZAPo49Dkm68=;
        b=EpVvoR5YVLpQ4e25j9YMT//Qz7oWIPu52dB3RhA5RzUdH0tSs1/wajPY1wmCK0+H+x
         BnswJk+N89kkjhzPHE+lZZoiwTuWHhiIIa+Q9Su6+G0XJOISBGRDMMu1HsKx6KV4jLvT
         dsVhR9oWqRKZnLTsiWi9IMlFEROJnIa2VBPQyO1u7Sh8SaKVwYZ04qdgJfqFPMfpBzgi
         5sHaPjiyzdh+JAL5jYZ6h7G1YFmyPstNvZm/z0ZZL+Qdv/A3+AOY+D5sagGL4FApeiCI
         l9pD5cfFccxhi89Zp2GjuZx2GUUJdmtvpbBRq5+0gsDg+2MU/SKsP0NJiqzlhepJXBDy
         orVA==
X-Gm-Message-State: AOJu0YzqFE/AvXULZWukqhXMdMtEl8C1uwzsIxcX7w3w8/Qa4+syUFNG
	K/kbBvuP0n10mmFZ5U95ibD1ZMXvPr+b5SJrTSkjvD0h+KzO3nhmcOeKUhj2JOdtDUzxeqcZ2uh
	Yh2ukoLrkYCgl2sxB
X-Received: by 2002:a17:907:d89:b0:a26:9974:2015 with SMTP id go9-20020a1709070d8900b00a2699742015mr3136666ejc.4.1703170851709;
        Thu, 21 Dec 2023 07:00:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJpypXsvoEs7jA+n4aMhW++WowH6Qw/3yFlSzxfV9ANbsvM2JbTF/6Ksw6Fyl01Hwg+iuAig==
X-Received: by 2002:a17:907:d89:b0:a26:9974:2015 with SMTP id go9-20020a1709070d8900b00a2699742015mr3136641ejc.4.1703170851385;
        Thu, 21 Dec 2023 07:00:51 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-246-124.dyn.eolo.it. [146.241.246.124])
        by smtp.gmail.com with ESMTPSA id dx15-20020a170906a84f00b00a2363247829sm1027241ejb.216.2023.12.21.07.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 07:00:50 -0800 (PST)
Message-ID: <7dcec457605bf34e6afb9c6f8c3311a572a7aa13.camel@redhat.com>
Subject: Re: [ANN] Winter break shutdown plan
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	netdev-driver-reviewers@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>, Johannes Berg
 <johannes@sipsolutions.net>,  fw@strlen.de, pablo@netfilter.org,
 torvalds@linux-foundation.org,  bpf@vger.kernel.org
Date: Thu, 21 Dec 2023 16:00:48 +0100
In-Reply-To: <20231205101002.1c09e027@kernel.org>
References: <20231205101002.1c09e027@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-12-05 at 10:10 -0800, Jakub Kicinski wrote:
> tl;dr net-next will be closed Dec 23rd - Jan 1st (incl.)

This is a gentle reminder that the netdev winter shutdown is
approaching.

Please remember then during the shutdown only fixes (for both trees)
will be accepted.

Please also don't rush out of the door any pending feature before the
shutdown :)

A nice winter holiday to all the people out there!

See you next year,

Paolo




