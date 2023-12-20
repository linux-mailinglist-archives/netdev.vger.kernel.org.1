Return-Path: <netdev+bounces-59182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E37819B24
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 10:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4523EB20EDB
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 09:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A69F1D543;
	Wed, 20 Dec 2023 09:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="KB1j5PCo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EF21D53D
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 09:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55370780c74so3648448a12.1
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 01:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1703063452; x=1703668252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+v0fE5jKaNBwKCEajCCubecf7GuVrsOPuUZ1oyddEgM=;
        b=KB1j5PCoj8rtMhkfOTgxczc/5wZvNLcIbS8KCwp1c2lOJXgVwh/qh3R1zO6BepLyuR
         BpHfoR8z1EtH5xrpISNroGVOtuvrYtiizOpj9rV/p5JVWd6BT8QIQ6cfe+Zz2XSzuCPp
         IwYaRU4eosOm5pdDcSd65Vbem1bjOphG4bTLtRbBONArPR8ZEwqx0nU7lNPTozvoB1M+
         CvAcrSGbZUqAm9Q/OTi6uk0qeg4vU80ogdejzjsZ2D623nGCu9ydxH9NGM5KqkyNEK5B
         4rUKeYqN9GTlfAHtMQWtI5JwiV/RTlN42z7BnXZZdRposKBqbU+g0nAXJE7tCkobUxek
         Adow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703063452; x=1703668252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+v0fE5jKaNBwKCEajCCubecf7GuVrsOPuUZ1oyddEgM=;
        b=NXb8VFcFi8+UcuCYcESR6wN/GLLHgJRXRbIx7ztcigN0tlWYSSHyRlPTDT8SQQCN5p
         oyXhDhxYuQfI/FS2oOAu3FUoDHWUCjaPi+ZNHTCHby/13r9SOgONaXmflNNhUfRP63R1
         ZDLqhsLalHpYQsKT4OasmrHeyJ373gwjIr5e/ivgfxz15LE0dMZ+Wx+7GG6LdRijHHIq
         7YZ8OUx5oZMTsNC2n80GARG0D2Fa8jSj5f/1Lbb/npEY/OJXHqBftT7bIRfjfbLsJaTS
         zTLU24lEfBu4k7xVFrWqp/w3Kk5Fy2TyY7cjVATgtE07Mbrzl4NE9UxjW6a2FC1qo406
         BEVw==
X-Gm-Message-State: AOJu0YysxNMdpFzJBstDxwTxb+/emPtVEqUEpcECcdjOpnJOBFBSKx05
	Eu7bEqVnE3SGSUhvggeR7rzsig==
X-Google-Smtp-Source: AGHT+IEqrK2jbaA2i+1nfz5XYzN2BPsY41Nnqro8du+5cvtwVQUNml/czk6hhUD4xs+iR+C+28cY3g==
X-Received: by 2002:a50:9b5d:0:b0:553:6c38:148a with SMTP id a29-20020a509b5d000000b005536c38148amr2275734edj.39.1703063452203;
        Wed, 20 Dec 2023 01:10:52 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id ij24-20020a056402159800b005529a6a185esm5609114edb.84.2023.12.20.01.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 01:10:51 -0800 (PST)
Date: Wed, 20 Dec 2023 10:10:50 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: richardcochran@gmail.com, jonathan.lemon@gmail.com, vadfed@fb.com,
	arkadiusz.kubalewski@intel.com, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ptp: ocp: fix bug in unregistering the DPLL subsystem
Message-ID: <ZYKvmqszs6P4wqim@nanopsycho>
References: <20231220081914.16779-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220081914.16779-1-maimon.sagi@gmail.com>

Wed, Dec 20, 2023 at 09:19:14AM CET, maimon.sagi@gmail.com wrote:
>When unregistering the DPLL subsystem the priv pointer is different then
>the one used for registration which cause failure in unregistering.
>
>Fixes: 09eeb3aecc6c ("ptp_ocp: implement DPLL ops")

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

