Return-Path: <netdev+bounces-56646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF5E80FB75
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 00:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68764280D05
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 23:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4587464CF8;
	Tue, 12 Dec 2023 23:36:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F030A0;
	Tue, 12 Dec 2023 15:36:09 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a1ca24776c3so1476376266b.0;
        Tue, 12 Dec 2023 15:36:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702424168; x=1703028968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMi0uQa7kDuWp8ZVNozIIQU/VZpmwLeFFMa7qTy3Qzo=;
        b=XlFp1FBSAqJ3IooVv7/7No+J5ZtjnmqCH+WUp+6899zuAe9jmd6PSHt4vAg8N5KGVQ
         LOFN62Uhef6KskfGpugaLKa/i49HyZZF6XdYCDbweauUqDNHbgAB55OeGjsbfNsxUDfp
         slTE7s7snczjmYzCpjA1wFcTRPt2QphSK93JMV8xYgyvWTx5Bjk9KxvxwfQEOVns10hw
         8pSTPbRRbbdbo88iKD+JlairHlGP05MPW+fUaGS1U5Boko8E38j2obHuL3paMXr2lojj
         VDhjtq13E5BO9LYz/QmVu8XR01UOx6L0L1i2vtriHGTaAEQDw84qFCHTc5PY2S3dnUXD
         eoNg==
X-Gm-Message-State: AOJu0YxMhImJqHduycfrWLo+093CI0VTx3bQH31R8c6x4jm8dqmntUNR
	sAMFoYP3RrSHXg2EdoXLOW4=
X-Google-Smtp-Source: AGHT+IFLYnQ5pkn8tDrEG+L9OkLnTAQOjSr4cmJW6QsSoNW4z0yCC1EtaDr8AsMsCv4W0UANeiZzSw==
X-Received: by 2002:a17:906:8445:b0:a1c:7671:8806 with SMTP id e5-20020a170906844500b00a1c76718806mr7311435ejy.0.1702424167841;
        Tue, 12 Dec 2023 15:36:07 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-003.fbsv.net. [2a03:2880:31ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id tz9-20020a170907c78900b00a19afc16d23sm6904963ejc.104.2023.12.12.15.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 15:36:07 -0800 (PST)
Date: Tue, 12 Dec 2023 15:36:05 -0800
From: Breno Leitao <leitao@debian.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v3 13/13] tools/net/ynl-gen-rst: Remove extra
 indentation from generated docs
Message-ID: <ZXjuZZClusMMsY1x@gmail.com>
References: <20231212221552.3622-1-donald.hunter@gmail.com>
 <20231212221552.3622-14-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212221552.3622-14-donald.hunter@gmail.com>

On Tue, Dec 12, 2023 at 10:15:52PM +0000, Donald Hunter wrote:
> The output from ynl-gen-rst.py has extra indentation that causes extra
> <blockquote> elements to be generated in the HTML output.
> 
> Reduce the indentation so that sphinx doesn't generate unnecessary
> <blockquote> elements.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

