Return-Path: <netdev+bounces-17982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D97A753F5D
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 17:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF4B328201E
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 15:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E419814AA9;
	Fri, 14 Jul 2023 15:55:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C4DD521
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 15:55:08 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BA030F8
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 08:55:06 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6687446eaccso1996409b3a.3
        for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 08:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689350106; x=1691942106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=23iFgtcXrSM/wqHFC50gmHfN2DfdTspVrWVZMTWF67M=;
        b=jVVndNxSJywFc3NlTe7W4yP3yU7NCgigpzMr+FQbbEvXGao5yncV705uEsUHe+SsoH
         99ahIHBc808HZFPmudJtgOEMfoALXOrhBGEH/5iOoJP0M0QQaAurUJwVbwvDh8rCWyFm
         0mOdTbt8hmBwtxDeUh5QRPqHwXPIqgVZNGldoXiTm0eDhVqBfh+70yBcJwuiProAPmNP
         q/bsMSOuP5fGR6gpmHPhHBCAGFMboGnKQPaY5xYLCGUxj9eKBY7inLb+03hQDErrcHpw
         o1qif2uGPWsACD+WU5iH4kmBUQe/D+z7BmCSmmyvl9y8UNGUZZpD2xWPHtSqInNnfuFp
         5rXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689350106; x=1691942106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23iFgtcXrSM/wqHFC50gmHfN2DfdTspVrWVZMTWF67M=;
        b=Mfx4hOxSofImLs8o6Wk12aVecQEWIeFZV+4OakdL1lwCPWV6qerMp9nJ+20vzL36Xm
         XSaltgYDnyrIR+Nq1Cbg1XZRtwU/6gQ3Y7OwzEZycVI5kShzrO45gygpEHRMkRMZGwX1
         ciOWTHMViJVORld4cBxkrd7auKo7cf8PHIYaySVkCYphnKhEM8ayNq5DNRj9TUTHfUKF
         N7fkV+ZCnbMU637cxvqEJbeAsRG9Q/vqWmWMi0A+f6R5ahlXi4kdUhJHikfhoa6htYVL
         WI+ZeGFGsJFe3Lhcvpq8eph5v6kJPjaAalu6EJh+atR9nXMF6tCVdq8MRCDNG2pbHuVf
         JJ9g==
X-Gm-Message-State: ABy/qLbcXJrFbVYcP79dPAV63RzRtay1r2eu5TMflvcvM6S3JoAfRDgO
	oQXcyHUzGp9vd0E5KD8I20GYBw==
X-Google-Smtp-Source: APBJJlE1OjvT/TWbZXaXcXtxRNjTULARYcXX/dBfz79zC72vXKyKqx8JeuoEXOUCn7f0w2b2Le5zeg==
X-Received: by 2002:a05:6a00:1951:b0:668:731b:517e with SMTP id s17-20020a056a00195100b00668731b517emr5873790pfk.24.1689350106259;
        Fri, 14 Jul 2023 08:55:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id t9-20020a63b709000000b0055be951145csm7037672pgf.36.2023.07.14.08.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 08:55:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qKL8K-0017jv-8O;
	Fri, 14 Jul 2023 12:55:04 -0300
Date: Fri, 14 Jul 2023 12:55:04 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mina Almasry <almasrymina@google.com>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Hari Ramakrishnan <rharix@google.com>,
	David Ahern <dsahern@kernel.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Christoph Hellwig <hch@lst.de>,
	John Hubbard <jhubbard@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jesper Dangaard Brouer <jbrouer@redhat.com>, brouer@redhat.com,
	Alexander Duyck <alexander.duyck@gmail.com>,
	Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Eric Dumazet <edumazet@google.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>, Kalle Valo <kvalo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Jonathan Lemon <jonathan.lemon@gmail.com>, logang@deltatee.com,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
Message-ID: <ZLFv2PIgdeH8gKmh@ziepe.ca>
References: <04187826-8dad-d17b-2469-2837bafd3cd5@kernel.org>
 <20230711093224.1bf30ed5@kernel.org>
 <CAHS8izNHkLF0OowU=p=mSNZss700HKAzv1Oxqu2bvvfX_HxttA@mail.gmail.com>
 <20230711133915.03482fdc@kernel.org>
 <2263ae79-690e-8a4d-fca2-31aacc5c9bc6@kernel.org>
 <CAHS8izP=k8CqUZk7bGUx4ctm4m2kRC2MyEJv+N4+b0cHVkTQmA@mail.gmail.com>
 <ZK6kOBl4EgyYPtaD@ziepe.ca>
 <CAHS8izNuda2DXKTFAov64F7J2_BbMPaqJg1NuMpWpqGA20+S_Q@mail.gmail.com>
 <143a7ca4-e695-db98-9488-84cf8b78cf86@amd.com>
 <CAHS8izPm6XRS54LdCDZVd0C75tA1zHSu6jLVO8nzTLXCc=H7Nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izPm6XRS54LdCDZVd0C75tA1zHSu6jLVO8nzTLXCc=H7Nw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 14, 2023 at 07:55:15AM -0700, Mina Almasry wrote:

> Once the skb frags with struct new_abstraction are in the TCP stack,
> they will need some special handling in code accessing the frags. But
> my RFC already addressed that somewhat because the frags were
> inaccessible in that case. In this case the frags will be both
> inaccessible and will not be struct pages at all (things like
> get_page() will not work), so more special handling will be required,
> maybe.

It seems sort of reasonable, though there will be interesting concerns
about coherence and synchronization with generial purpose DMABUFs that
will need tackling.

Still it is such a lot of churn and weridness in the netdev side, I
think you'd do well to present an actual full application as
justification.

Yes, you showed you can stick unordered TCP data frags into GPU memory
sort of quickly, but have you gone further with this to actually show
it is useful for a real world GPU centric application?

BTW your cover letter said 96% utilization, the usual server
configuation is one NIC per GPU, so you were able to hit 1500Gb/sec of
TCP BW with this?

Jason

