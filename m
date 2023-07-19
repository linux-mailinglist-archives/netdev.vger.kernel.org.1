Return-Path: <netdev+bounces-19006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F008E7594AE
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BF9E1C20837
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C778813AFE;
	Wed, 19 Jul 2023 11:55:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD7D14261
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:55:22 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64280D3
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 04:55:21 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3fa86b08efcso11655325e9.1
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 04:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689767720; x=1692359720;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/a4ZoeUIQd+ndOko8895m/fdnD+arM41bba+h2c+H8w=;
        b=GcXttjRnRDe2jOeTJnEpW8ubXZXCnkzYM+dAIG5priC9SwQxUgu77jJgi+zEdL6MT3
         2k9KvGJlLT7w3XNiPcPXia74v934VLAQiryLdIxLuil19UQI0hnLL4tFGHUbSBWTFMg2
         qBxNuXhg20JEVe84j9D5qip06rPLH1eDv7orLZ4fKWMDBIqmqWIq4IFzVyG4OdSWdWL7
         L0Whp5Dy5d8G3MD+boZW+izlGN4enganffhpWConDTixmuB7g6WemdoP2qOiqoX91p4Q
         uqih0pR7U0aLlkEvsbsoFCzdp4HDTIf16w6qdqrTKT1PBscSb8QksW6xZj41T0vSXZxZ
         3r2g==
X-Gm-Message-State: ABy/qLaJxmZ8ftPkbkn76uZBgHvJg1BP2h7XnUvPkwukW9pnuUeYhESl
	W8j3NCYXq2zXB0hkoJKCsYc=
X-Google-Smtp-Source: APBJJlESnghbYQXGyfZxB4mM4YLWOfrFx755yr/rKauJE470zLJzZB7SXY+XrWpq0hmJNvePuvLq+g==
X-Received: by 2002:a05:600c:3b89:b0:3fb:f4f1:2739 with SMTP id n9-20020a05600c3b8900b003fbf4f12739mr2344442wms.3.1689767719536;
        Wed, 19 Jul 2023 04:55:19 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id k8-20020a7bc408000000b003fa95f328afsm1509740wmi.29.2023.07.19.04.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 04:55:19 -0700 (PDT)
Message-ID: <f26a613d-1cba-5448-1365-c51ad7aace02@grimberg.me>
Date: Wed, 19 Jul 2023 14:55:17 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6/6] net/tls: implement ->read_sock()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Boris Pismenny <boris.pismenny@gmail.com>
References: <20230719113836.68859-1-hare@suse.de>
 <20230719113836.68859-7-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230719113836.68859-7-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> Implement ->read_sock() function for use with nvme-tcp.

This implementation looks better.
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

