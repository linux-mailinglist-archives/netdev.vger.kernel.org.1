Return-Path: <netdev+bounces-28117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A75F77E438
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76EE281AB3
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 14:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E5A12B7C;
	Wed, 16 Aug 2023 14:54:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFD3101DA
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 14:54:45 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0066273C
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 07:54:35 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a7a180c3faso5364389b6e.2
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 07:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692197675; x=1692802475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=34ISkCUz1jnkCM9CzotxJ6PEzk8hIrTwfNJQkrqLEAA=;
        b=MZvMhAnaM2pvbykBiB+xA36kD+rqxilRCG4J7Pj0OEZlLEhf3i7InhpYayvFizM0UK
         drDZSgIoboMqzbNIB3KIGxRlxk5IbhgwbxN1NY9ryTwz8GVfm/8EgC6vQAzvRzRdGnJU
         Y1tZKap70XvlLzdt7W0Txg411NdT1I+1sRIYe6XkEtT+g0xcEZzhfPpqiun2e2prMGIO
         AvG74eNTzKlNr1ZTDGl0QpMIuiPLfW7HSQ0X7mjrwAWeikSqhrTGKMv8U2GSUrPX3kIW
         efFdBJrghvO+Nb31ZJN7MKjpwy2nNLdLMQyGQpGaiCd44TPNncI9+19i4EI24IU4OfCU
         ev6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692197675; x=1692802475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34ISkCUz1jnkCM9CzotxJ6PEzk8hIrTwfNJQkrqLEAA=;
        b=FfYoBbK5llRudd7bUsCeSRqWKNB+ELkX1Zp0hEBgAgaN+vsh08lX/rm7wxgLPneDBj
         e0XV9p8k7aqEqrK3sDIwDqm94tAmdmXyvoMIozJCszz2kDQxkic6KKPKCdLvLBON5ey4
         wnAPUO+iTMoyvCseGqIDxlnR0Jf8afgiXD6lWVdvQ8Qerma1B+TpbNPbFlJ38KhVuo/d
         wJ3aCqlGfc5D6tuNsYIy3VsOA9Z514N3vrObbULXUAVZqOEveTQZNjePBdyr7kZUaljA
         U5o7dG+0mlbBeun0y/YHNfNv8KFM14uQrFtrXdlTT1c/Z4CDvykl5qrK6y5fix8d+jtm
         7Wsg==
X-Gm-Message-State: AOJu0YxQKSzQUcvKMWKUoi50i9xgXkXLb8cJcAeny2Mbio/hMk9dHg1j
	Zfg4IxGT/DjeNW1y6H/ZxYs=
X-Google-Smtp-Source: AGHT+IHwzSjE2j0Ai5bY6IPgpoKrIZUi2VPGFpfVW0x76kPjxFN7Yp9LAsKz87fMGtcVbWhAJeGrhA==
X-Received: by 2002:a05:6808:9a3:b0:3a7:22f0:1fc2 with SMTP id e3-20020a05680809a300b003a722f01fc2mr2185973oig.13.1692197675047;
        Wed, 16 Aug 2023 07:54:35 -0700 (PDT)
Received: from t14s.localdomain ([177.220.180.11])
        by smtp.gmail.com with ESMTPSA id et19-20020a056808281300b003a0619d78ebsm6547908oib.55.2023.08.16.07.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 07:54:34 -0700 (PDT)
Received: by t14s.localdomain (Postfix, from userid 1000)
	id 9D0956E70AE; Wed, 16 Aug 2023 11:54:32 -0300 (-03)
Date: Wed, 16 Aug 2023 11:54:32 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net] net: do not allow gso_size to be set to GSO_BY_FRAGS
Message-ID: <ZNzjKM1F+a6PVRSr@t14s.localdomain>
References: <20230816142158.1779798-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816142158.1779798-1-edumazet@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 16, 2023 at 02:21:58PM +0000, Eric Dumazet wrote:
> One missing check in virtio_net_hdr_to_skb() allowed
> syzbot to crash kernels again [1]
> 
> Do not allow gso_size to be set to GSO_BY_FRAGS (0xffff),
> because this magic value is used by the kernel.

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

