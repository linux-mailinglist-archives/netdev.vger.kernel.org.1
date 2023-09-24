Return-Path: <netdev+bounces-36049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C647ACAB6
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 18:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 460E01C20506
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 16:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C052D51F;
	Sun, 24 Sep 2023 16:09:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEC8D279
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 16:09:49 +0000 (UTC)
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A621A83
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 09:09:46 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-49618e09f16so1481416e0c.2
        for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 09:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695571786; x=1696176586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QURNpEXBO9G9PFEIad+n+sx08/etGECzvj5xzBg1AHc=;
        b=Mu38G93LdDZi6Tfc8ULbRJ+Fn59LobapTUmb148KJRLFbEHZYliZ1XuLKxo+w4XfUL
         mIr1iPKFCeFPHgQUAdBGXAWPFWUbk6A3iqvMEIRzuR837hmslknI+LgpPXAI34ylrpI9
         QlJEcDqI3RHGnBnbj+3gs7i46Ug0qy2xqM3ilSOvw79T49BBYfQbMS2SAPTfbh/lK170
         c7mQiVfzA/1er1oLYON0xi3UAONpQTdH3qu/E4P6w6tv4ZuXewdN0wky2a3XDazV2CGz
         7fgPcjtqsL326jk3NPVdfyWpCsV8pA7rSWB41gIGzUinn9tTbmFsVYEPadcOfw5VVQUP
         oDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695571786; x=1696176586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QURNpEXBO9G9PFEIad+n+sx08/etGECzvj5xzBg1AHc=;
        b=SDPg4GIqZZ3l9S1Aj+JtSSPcyItFrOFYQLuEHt11XQ/2f0gvC/9YdMFetKRBtJLpCn
         GHo1ydGt35dVwZ0BEdjKs5qrUQSGLx6/gPvl/W6e1pXeiscM38qsBeH3Tvv1M7Xg9sOr
         LdMLPbxrdS+FyTKFSUbTqcmQeTwzOF9Xj9LRL8ukcKfmZgWMUtm5cuqwklnhOFYVMpps
         7enILujLgHQjE75iQPxzh/mrICx0ca7xbJFQ6+QOhQxtx7F2MFq/fVeL37JeiRgBWno/
         z0OqBT9yZvnX8JCHULPrEDVGeQqxwdlhA4oRP8mwOcja0OvS0nx0uBqIP50Ym+aevXPp
         vjXw==
X-Gm-Message-State: AOJu0YyVYr1DKDKZ2NF8495QEjOI4rKmQPVwK10eieOrhmCNDpMVWBws
	CeHjr7LJels2xgtWSo0DshGipnIIL966yacmMQ6XUDrezkSD9SpkrNwBZK7A
X-Google-Smtp-Source: AGHT+IFAzYztu/leVlHB87uTORAV79NsBlHofE0WyNeBKXpEGD0Z3JYN+VqzW8QQg6bcUdNe2n/00DEsfLFyYIY2pug=
X-Received: by 2002:a1f:e043:0:b0:48f:a5db:2cd4 with SMTP id
 x64-20020a1fe043000000b0048fa5db2cd4mr1535377vkg.4.1695571785498; Sun, 24 Sep
 2023 09:09:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230922220356.3739090-1-edumazet@google.com> <20230922220356.3739090-2-edumazet@google.com>
In-Reply-To: <20230922220356.3739090-2-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Sun, 24 Sep 2023 12:09:28 -0400
Message-ID: <CADVnQymdOTbFRQhZZRw1pfTdhKBeoGR32D9Yj9hE4=RgcJKtJg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] tcp_metrics: add missing barriers on delete
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Yuchung Cheng <ycheng@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 6:04=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> When removing an item from RCU protected list, we must prevent
> store-tearing, using rcu_assign_pointer() or WRITE_ONCE().
>
> Fixes: 04f721c671656 ("tcp_metrics: Rewrite tcp_metrics_flush_all")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Acked-by: Neal Cardwell <ncardwell@google.com>

neal

