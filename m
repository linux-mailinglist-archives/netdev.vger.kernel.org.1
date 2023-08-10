Return-Path: <netdev+bounces-26527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB76C778016
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C541C20DC3
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D55122EE0;
	Thu, 10 Aug 2023 18:15:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822701E1DA
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 18:15:46 +0000 (UTC)
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAEE2717
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 11:15:45 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-267f1559391so1437703a91.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 11:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691691345; x=1692296145;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zDJqXR5m2KUNnseaByBHNYFqrPpM8rBBB0IoW+O5dZE=;
        b=aDkiebELOOGXYHQrmahfWr0zcrm+FtBzIFp14WmqEwigrkdKRGxRTleRExjuCKwwg9
         5rw3JM+sLeLW7Q2iiqR+XyBA9nWObwbIhDLsrJwmePekll4/tNVc9hbQUQvEvkF9/Hyr
         DImUlO0930CjffY/bTfIeGB1PIn/a7rpgrhG9Yk1NexsxZ0V22Ul3XqF2+wuwJ0fBOnH
         35NiFDoR0/GKwyx9stykuyn1u8LI/5RBC9HoQ8AcGwJ7vLBJHD1oGjTRBJvyxUTvkCpT
         ZUFWOLANOAUu+y3J0Ka2VUiBM20xQDGWzNX6SXAXYVHrPLtrNLQlg5PQH18QDiSGGCDJ
         /Ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691691345; x=1692296145;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zDJqXR5m2KUNnseaByBHNYFqrPpM8rBBB0IoW+O5dZE=;
        b=cebwAYjb08cACGB+V8DV1hz8y8H87FPAE2GNLFIAT3sKDZZcO3tHgyG0f6Rko+tlcc
         /xTeAwxzsaf7BSBbOMPAjTJob873aVH32Veik4Fl10oeWzZk0Eds+WQUw5l/jQU5Twuz
         151T+HQ14Byg6hR+Flw4njMhoDqyHuUdT9iw5sbNZL66CAVtlB7HwNeH3OOnH2vyJ4Ra
         DMwRoe/Kgg/WTQbv39R8I7ItIQKNXbM/r0ymqF4ikm3Ms7nednhOn7MeDriPvxF1T7f9
         auG2/HKVxxRKOmBziaj1S7k53pqqBsHuOIXol7s4mZWrMS0TwPyvKCI/TDBHldrJT+Vi
         4Qpg==
X-Gm-Message-State: AOJu0YxF15xNLP94hW+9QMGdP2uNgBeeWWX2f0rOWfOoWaTPVM41GcQc
	+vTGx+dGcHS7M04WE7KMAfto6aQ=
X-Google-Smtp-Source: AGHT+IG1z+cYQdG/jyP7jR+G5rckeySCorDQaXuh/tyWmxRRDVw5gWi+qJfLVIaZmieifRWgoXoSUNY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:a78a:b0:268:2c37:3f59 with SMTP id
 f10-20020a17090aa78a00b002682c373f59mr717796pjq.4.1691691345251; Thu, 10 Aug
 2023 11:15:45 -0700 (PDT)
Date: Thu, 10 Aug 2023 11:15:43 -0700
In-Reply-To: <20230810165223.1870882-1-tirthendu.sarkar@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230810165223.1870882-1-tirthendu.sarkar@intel.com>
Message-ID: <ZNUpT+yI/OrLnxKy@google.com>
Subject: Re: [PATCH bpf-next] xsk: fix xsk_build_skb() error: 'skb'
 dereferencing possible ERR_PTR()
From: Stanislav Fomichev <sdf@google.com>
To: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, bjorn@kernel.org, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	dan.carpenter@linaro.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/10, Tirthendu Sarkar wrote:
> xsk_build_skb_zerocopy() may return an error other than -EAGAIN and this
> is received as skb and used later in xsk_set_destructor_arg() and
> xsk_drop_skb() which must operate on a valid skb.
> 
> Add new parameter to xsk_build_skb_zerocopy() to explicitly return error
> and invoke xsk_set_destructor_arg() and xsk_drop_skb() only for a valid
> skb.

Maybe I'm missing something, but seems more complex that it should.
Why not do the following instead?

	} else if (!IS_ERR(skb)) {
  		xsk_set_destructor_arg(skb);
  		xsk_drop_skb(skb);
  		xskq_cons_release(xs->tx);
	}

Why do we need to separate the err?

