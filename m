Return-Path: <netdev+bounces-27126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21D877A6B0
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 16:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2EB1C2031C
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 14:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7501E6FCB;
	Sun, 13 Aug 2023 14:04:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694BA5235
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 14:04:32 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B438EA
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 07:04:31 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3174ca258bbso872994f8f.1
        for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 07:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691935469; x=1692540269;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bAsddR+jVmFAzvgtlxuMFEE2KhkgoPbVN+pSO+lelZw=;
        b=YINoPzPBy529oIPs3p3h8CGtu40iEmCM2CBjMUXOnnqAtkqmsN//bLpcbWpVyuNp9F
         Y2xnkNlJitfCr0HRPXDjhYlLqfJ12go8ltoPo4CnQm9d63x7Pa2EtrMQUMYXwCO4J1e3
         MyA8nCm70r/2Xzsw9HIPO3il8j7CjWbxREyZS8OHzDdTJ0NtbLFfVZ6NH2VUV/Uy1tDn
         QqRmvBe1LK4gKgABHdAac6ESRiVsq4O6uVTpAtnLY5DbYTsmnl2T8ibqZ9eJmgSaQsoH
         b2kpavNV6qZKNX6y9XRr25qj2PUIxisG9LlymRk1etd60ud+kL0xwHUWAJcho46ssFPn
         UBew==
X-Gm-Message-State: AOJu0YzVhO9zRLSRzUyVfHS/nbNGU4Me8w3H00CUodtV9W41cVB4fTUJ
	VxvE748rsTFF2rtLZ8n1hgI=
X-Google-Smtp-Source: AGHT+IG36UZ5ZHqk3SFV7IS9EN2sM1NW/EdVfaO9OtPGbpUmfFPXojtu7jtQg0IH4XJYi0n8eVhpAw==
X-Received: by 2002:adf:f68b:0:b0:319:6ce2:e5a2 with SMTP id v11-20020adff68b000000b003196ce2e5a2mr2828874wrp.4.1691935468082;
        Sun, 13 Aug 2023 07:04:28 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id ks19-20020a170906f85300b0098733a40bb7sm4623246ejb.155.2023.08.13.07.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 07:04:27 -0700 (PDT)
Message-ID: <36886d94-b6b9-4147-6795-03adc63c7b71@grimberg.me>
Date: Sun, 13 Aug 2023 17:04:25 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 17/17] nvmet-tcp: control messages for recvmsg()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230811121755.24715-1-hare@suse.de>
 <20230811121755.24715-18-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230811121755.24715-18-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> @@ -1705,6 +1772,7 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
>   	}
>   	if (!status)
>   		queue->tls_pskid = peerid;
> +
>   	queue->state = NVMET_TCP_Q_CONNECTING;
>   	spin_unlock_bh(&queue->state_lock);
>   

Unneeded hunk here.

