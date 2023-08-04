Return-Path: <netdev+bounces-24501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A943777064B
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 18:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6021C218D3
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 16:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9224A18041;
	Fri,  4 Aug 2023 16:49:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C3DBE7C
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 16:49:54 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEFE3C23
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 09:49:53 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-403a3df88a8so16107751cf.3
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 09:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691167792; x=1691772592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LkUL2PlOzfT58q9qudjtzFzvb7OK02mCRFsTl32ovnU=;
        b=kUyybcKNzzLZ7ehNjnqiw18cmIQMfGtVGlv/zhCpGofq95hPLktzHm0FWZ0gMitYpx
         yL+BC6jbA3nUwlUG4S4mDOVQsSdrkhbr6jgrXYwC5ezRKdka6S3+ySUnpYtgwvvuYGCG
         aadp/6aNQzJOZ62ymVGZjgtzBoPTTHTEfz1FGnzQb42Sz4BArQ4bPFLvsqsu9auDdPt/
         aK63jDpd5hyPPpGb0G7+L+7ruCHNtEtcBi77gJMLKEaLy2eTQyaMy3k5XJWpqnj2r5Y9
         gP2Hder6QnLQy90m4zXSFcRdTkSHHgrr9TImCthlq18CvvVkSPyW8VOoHvGkXtQm3s6n
         QlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691167792; x=1691772592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkUL2PlOzfT58q9qudjtzFzvb7OK02mCRFsTl32ovnU=;
        b=ZAv1YnNvcYaTFU5ScDX0S38xLuZF360F0Aw/cCmq0xnKOOpFnqL1rSPPM78UrnLX2N
         5S+22I0w8jqc9hocyr7QgaLzcuDWbpFwaosR+v/Vzvk5dPRNuf5ySb9ZdlD3WsN4U03E
         V5BREQW5cnIx7gejUTuos39/YR3KPMEcWeVCRD6+dHnNw0uI3UBP8OeD3wKDAqa7AZfm
         i1DvMza8sQDmUF/RbwerX3qd/UIZXQ4DIxbPylwQYsLQDEF33iWrK5VpclSQuqtr3vF2
         5XGdXsoSpNPEb/W6TkR5Uc9WKEnK2Og0Qn/yo4ue3nba6w5OkqKdbd3Syfg2G7gCoq35
         q/kQ==
X-Gm-Message-State: AOJu0YwZvty5vWCY/KTi9rzLBNp3NIHiedpMrAXkEDMiQVx3synA0Hjk
	PkodcOONVW1o3mmAgdCGE529Yg==
X-Google-Smtp-Source: AGHT+IHj+Quw/k2Ut+pAvKfZ2oiDEj8XGnx9S5QXbT4XVTYEsHM+FYwYA29FEaM1sPq0Tck85Et93A==
X-Received: by 2002:ac8:5945:0:b0:404:c430:6695 with SMTP id 5-20020ac85945000000b00404c4306695mr3396490qtz.53.1691167792218;
        Fri, 04 Aug 2023 09:49:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id e7-20020ac84147000000b00403c82c609asm783399qtm.14.2023.08.04.09.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 09:49:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qRxzq-003v4Y-SY;
	Fri, 04 Aug 2023 13:49:50 -0300
Date: Fri, 4 Aug 2023 13:49:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: tariqt@nvidia.com, yishaih@nvidia.com, leon@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 00/10] Convert mlx4 to use auxiliary bus
Message-ID: <ZM0sLsxnP3PoI0lm@ziepe.ca>
References: <20230804150527.6117-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804150527.6117-1-petr.pavlu@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 04, 2023 at 05:05:17PM +0200, Petr Pavlu wrote:
> This series converts the mlx4 drivers to use auxiliary bus, similarly to
> how mlx5 was converted [1]. The first 6 patches are preparatory changes,
> the remaining 4 are the final conversion.
> 
> Initial motivation for this change was to address a problem related to
> loading mlx4_en/mlx4_ib by mlx4_core using request_module_nowait(). When
> doing such a load in initrd, the operation is asynchronous to any init
> control and can get unexpectedly affected/interrupted by an eventual
> root switch. Using an auxiliary bus leaves these module loads to udevd
> which better integrates with systemd processing. [2]

Neat, I didn't realize that was a pain point for distros.

Jason

