Return-Path: <netdev+bounces-56591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75D480F805
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 21:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7401C209EA
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 20:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8EC64130;
	Tue, 12 Dec 2023 20:42:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5303799;
	Tue, 12 Dec 2023 12:42:11 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50be9e6427dso6497201e87.1;
        Tue, 12 Dec 2023 12:42:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702413729; x=1703018529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEr2EEyHlqvY8hqMYfnv5/2w4pzDdykTpsY7QNoWjMQ=;
        b=eriv+k1X8+F/N3o2ymEgIkLDtjE012nVF7DhXv2fBgLuUQjY1uy95xVnzfi/FWfUl+
         kRSca3cjrkCKcKqkz4WIhWFPxVhvz9eCeIpPpEcfwVpnbgs+ll5j+N+Slh5zMFle7bxG
         XXY8RP4nuKubFgqfiBR0y2oKWLrM4t8DhsH6BBsPIv8k9fOAZ8FU4tRDFrZgc/ibsJvC
         OiP+630ch6Xm5igndCyQ7vPXdMQMXFghTUeFIQMFye6K4VEEG8HaonpoRQeX444m/4e7
         OwGHVwVZuZWnvOgoC/sRsDgKuMBbGy3SKPD9+XhSc028YGMPbufruihXV3eepNtluuMF
         nC1g==
X-Gm-Message-State: AOJu0YxbSW/2E5cbml23agadYZAvQCHIFtiaGCJOgOLxUClfxp1TSEg6
	i0ann6sPle3GuB4G7x+cnI8=
X-Google-Smtp-Source: AGHT+IE1FpQgTddzUg67NUymApVyoORTKD/FR6f6QBtq/qNriy5xgfyRgNhRLUbRdpBiu4vpKrFlHQ==
X-Received: by 2002:ac2:5d4b:0:b0:50c:c6c:d053 with SMTP id w11-20020ac25d4b000000b0050c0c6cd053mr2605689lfd.31.1702413729466;
        Tue, 12 Dec 2023 12:42:09 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-004.fbsv.net. [2a03:2880:31ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id d11-20020a170907272b00b00a1e2aa3d094sm6860417ejl.173.2023.12.12.12.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 12:42:09 -0800 (PST)
Date: Tue, 12 Dec 2023 12:42:07 -0800
From: Breno Leitao <leitao@debian.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 11/11] tools/net/ynl-gen-rst: Add
 sub-messages to generated docs
Message-ID: <ZXjFn1Caid7wQTVp@gmail.com>
References: <20231211164039.83034-1-donald.hunter@gmail.com>
 <20231211164039.83034-12-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211164039.83034-12-donald.hunter@gmail.com>

On Mon, Dec 11, 2023 at 04:40:39PM +0000, Donald Hunter wrote:
> Add a section for sub-messages to the generated .rst files.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Breno Leitao <leitao@debian.org>

