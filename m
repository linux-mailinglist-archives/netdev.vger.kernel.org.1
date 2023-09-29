Return-Path: <netdev+bounces-36952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9377B2A02
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 02:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 2A0D4282AF2
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 00:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A6015B1;
	Fri, 29 Sep 2023 00:53:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808F810FA
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 00:53:08 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0872C1
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 17:53:06 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-536ef8a7dcdso4907a12.0
        for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 17:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695948785; x=1696553585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApHsbmysldl3ubY0IraXvKBJ81lcqmJuX+P7dTHdPro=;
        b=O1I6OdAlfzOJGAMwuLQx1a5InyImHKVe57Qg8ta5mmQsJQ66aDVIZ70ZokHZSBM5d4
         BoPR9VEyn5WsCwn9IDw3uh+OepGkZIRUlJyYsG9Bx5jRkaVxWkcMI0p35SoYX7NHv6aG
         CDSq1dD/Jc7aJiEOTtAFu357UVuPWuMPnA++kHu04xqtGuqefoqCQBJAmsDEnjrcCdaH
         V10/lAHGUD0ioJVSZoFz1NYZ+f/DRW5+5wxnx3ih36HbhFI5wML+k++lpS+J0QDkItBL
         WDKRSvFNN7SwqRx73AGbbuwZ+BMIoBke072kXaXnCa+o7CrVI2IsSa/GBj3BTg03UYSX
         V89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695948785; x=1696553585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ApHsbmysldl3ubY0IraXvKBJ81lcqmJuX+P7dTHdPro=;
        b=vwkB36+OyEO97C0zm435vhJbJkg3xKnS5c2R3TFvgn+oQbH9f7+GkMVYActu2KR87+
         LNe1B+kvB0OxTQRJT04HVeRBhFxtw9IfjgBzYmm4+g59YdPfmlw0461l04NjB1diDUjR
         vRce/HTRXCz5jBCHf/LbuOTpEEziTKeTG55DB1Gvzk+Xx4ISwUude8r1zzkxvhXASBB6
         uWJytClA8BCugfzmmj2lR6imMZ/o7nIkUyigsrO1gHO41sNRTwtW5S1vsLSDAjn52zAN
         ON8ViFFA861kX3Yr/oVmy9YNEk8bCAtrTZQ6GvyRf1qfwDFw1i2dc7em7PexdTnMRgld
         L/pw==
X-Gm-Message-State: AOJu0Yw+YKjlkQFrPi4551EGPKBQ+rFxIA+VfMJboTfY8URVC9BTRHoU
	Ik1ElsxoTXkcdlSsvuXep6G8MeSDrdZHTIZ80SOc/njj4jONqKh89Us=
X-Google-Smtp-Source: AGHT+IHZHMQvJs9etbwb7e8dfav3nW7gel1JHmqzLicJT8BmDl4J/bNFTqYiRB4Z0TLfjwSLV3HMzEk2e0iV2A1vWO8=
X-Received: by 2002:a50:9fef:0:b0:523:b133:57fe with SMTP id
 c102-20020a509fef000000b00523b13357femr488541edf.1.1695948785078; Thu, 28 Sep
 2023 17:53:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230927182747.2005960-1-morleyd.kernel@gmail.com>
In-Reply-To: <20230927182747.2005960-1-morleyd.kernel@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 29 Sep 2023 02:52:52 +0200
Message-ID: <CANn89iJJKcsj_0TZKX2O787rBetFEo0z-QzS5Tun2LrTpkkOxg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: record last received ipv6 flowlabel
To: David Morley <morleyd.kernel@gmail.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	David Morley <morleyd@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 8:28=E2=80=AFPM David Morley <morleyd.kernel@gmail.=
com> wrote:
>
> From: David Morley <morleyd@google.com>
>
> In order to better estimate whether a data packet has been
> retransmitted or is the result of a TLP, we save the last received
> ipv6 flowlabel.
>
> To make space for this field we resize the "ato" field in
> inet_connection_sock as the current value of TCP_DELACK_MAX can be
> fully contained in 8 bits and add a compile_time_assert ensuring this
> field is the required size.
>
> Signed-off-by: David Morley <morleyd@google.com>
> Signed-off-by: Neal Cardwell <ncardwell@google.com>
> Signed-off-by: Yuchung Cheng <ycheng@google.com>
> Tested-by: David Morley <morleyd@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

