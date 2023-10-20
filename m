Return-Path: <netdev+bounces-43109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A457D1707
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 22:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2207A28261A
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 20:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB37A1EA90;
	Fri, 20 Oct 2023 20:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkPeWt0E"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E71E24A16
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 20:31:33 +0000 (UTC)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F39D65
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 13:31:31 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-41b7ec4cceeso6941891cf.1
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 13:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697833890; x=1698438690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8A3rxN+5O0cBu7k0EXNY/6vM0efaqeEuPe9krzDiZI=;
        b=bkPeWt0EpzCEvHWZG0v+SIRhYxO6OM4RNFcj13Usp9KtAEyPdctqzO5hiT5i2udmRd
         LsI+WVDMilFgzxkHuJ7GbsIFXhHfTto7VB0GRuOrQkfSOa42uZyBoNwmpKToXnUh6RkT
         713twSFrIeSg49+Ab+e1F4rSepzADYas1zG7w0UxjDf54rT47tLbn1U7ne7Pc25JxMmu
         SbxJ6zbjsmht2OBiQ5DLcc82bd4yNFhsDmc5h7s4afKZs0N7WCfsFIrHjicG5XET8yYM
         5q8CtcqJMIwsP2h1flb670YvV1yZU0GqFMZ1zbj9oDSlWubsku7oGcfulxqlWYzr6lRn
         L6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697833890; x=1698438690;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q8A3rxN+5O0cBu7k0EXNY/6vM0efaqeEuPe9krzDiZI=;
        b=XS0GWutcPE31OYxrarpa8ZMyKyI6zqrmNekrXe26pkdJKS+1k4DpepoOoJ2hiMWyeJ
         IEwHCY/vV5QQHyy7S35LS4XraRGH+USQ21h5FMPyOMO/78Ywe9Tq8KEND1TeUBA83RSt
         HOFjvZwvRGQBz9v+HhYYd2wa3dWOc5YYp6byvTbM0oTGWupYQlhKrv/ru2N/DaFxNwWP
         02V4XAuWKxTzTmJtG2lp1ZBUugQnp8gvQeJfbbQYdU+Zv3Os/s6HxfSSHu/C22X6baIo
         wvr+Mf9K3CMCB3ynxCEw/XG+E9Dy0CV1f/ooYHpHcC3XjqrBx91iqi8ITtbJ8ci4VVZ1
         tWrA==
X-Gm-Message-State: AOJu0Ywn3/2vVCbB6wFBuVTm/nQtWxna43l8PAPuKwQDd9X587CSipuA
	Ang7e0Yo2ivW4CLCOqc4QY4=
X-Google-Smtp-Source: AGHT+IGYk5W6+2jkFxtOXJAJxjmEin9bhgYtesp0RyQP6GQONRBF83V4C8VHqvYLonYpigdaOPH/BQ==
X-Received: by 2002:a05:622a:1b8e:b0:41c:d916:75d9 with SMTP id bp14-20020a05622a1b8e00b0041cd91675d9mr2681924qtb.32.1697833890428;
        Fri, 20 Oct 2023 13:31:30 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id bn14-20020a05622a1dce00b0041aff9339a2sm848903qtb.22.2023.10.20.13.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 13:31:30 -0700 (PDT)
Date: Fri, 20 Oct 2023 16:31:29 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>, 
 kernel test robot <oliver.sang@intel.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Soheil Hassas Yeganeh <soheil@google.com>, 
 Dave Taht <dave.taht@gmail.com>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Message-ID: <6532e3a1ca13e_2945ca294ba@willemb.c.googlers.com.notmuch>
In-Reply-To: <20231020200053.675951-1-edumazet@google.com>
References: <20231020200053.675951-1-edumazet@google.com>
Subject: Re: [PATCH net-next] net_sched: sch_fq: fix off-by-one error in
 fq_dequeue()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet wrote:
> A last minute change went wrong.
> =

> We need to look for a packet in all 3 bands, not only two.
> =

> Fixes: 29f834aa326e ("net_sched: sch_fq: add 3 bands and WRR scheduling=
")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202310201422.a22b0999-oliver.san=
g@intel.com
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Soheil Hassas Yeganeh <soheil@google.com>
> Cc: Dave Taht <dave.taht@gmail.com>
> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Tested-by: Willem de Bruijn <willemb@google.com>

