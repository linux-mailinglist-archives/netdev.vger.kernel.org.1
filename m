Return-Path: <netdev+bounces-50796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CAB7F7262
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 12:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C030628188A
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 11:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EAB17723;
	Fri, 24 Nov 2023 11:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="KI0bV7Xw"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7FAD46;
	Fri, 24 Nov 2023 03:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1700823923; bh=SGi67enhya1f83hnmS1PP1kD7gxV9IFodCbUr699cD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KI0bV7XwdKY8O7YnnNEtkTiHR0Jk7K8y6KRwG+RDYVoIOoRXtAHa88oERtUig53jF
	 9wj1iRVNk/z7C+mwqzLdfgozwheVD3FJXgeruMsQ8uiip74Q0A7cpjNWkXvMbqkEhm
	 F0mms74+y1hyz4nzfMwn8gbvfwBst239DdE4fYIY=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 153054D1; Fri, 24 Nov 2023 19:05:19 +0800
X-QQ-mid: xmsmtpt1700823919tzmyqk749
Message-ID: <tencent_DB6586C0B361236CA97783A36451D772D705@qq.com>
X-QQ-XMAILINFO: OKKHiI6c9SH3eVzOCbbPvyCxtRkSlCDL9As+nlFyRj6P5/hKq/1TE1xb+9cCJk
	 LiVzVcJfEOXcNkHW08Thzwkhm8wKERST7kDswWhO2jyR9ZyeE/CPc+M9dVAqdXRQvZUroFCCcduo
	 PBZ/kLf4KVWe7BgX7nzfXWgBGkn6zlssgGVt6kpIJsSBGOmpE9Au8spdLXpHezjCaJz40sU9rT20
	 oDn7syLdzHgMQyUJw1M00vY8JyX3pRNcRymJXFTSDb7LMRBnVwLLc4LuQsk6OzmuhSEVFA4ft9De
	 Lc3dsTqesbHIlrrgBUzr93/E1lP/iW4c7aebaQ85nO6lzyQvriWasHNo/LVk5GXFSEHIcURsEZOY
	 QY31C4vCpc38oOrCiQoPtoNX4j+/uaEVuM6RDiBcjQWfAeOKzaJrhe9nBa5R2HcgdG+bcGg7VXlg
	 975JBmnbw5WwpiTTKDN2LOxXUa7xKdaqvS+JLksbDHB1Uc3UHg3MDkAEASTGbV9z8X4DHqOUmEhS
	 EkDij1K1iVnc8qYBRn87+9Nhgn6B0cslrr1fdsHgvU5Iy0TOXXkvxTtt35nmrp3PWdnoSeWmozBT
	 6AG8owFF1hrb9yTD5KIv5ungolu6fXqtWOmtDmamr0bSOef0hF1+wPrUS6X0G/q+YAGgdqa7LHmP
	 vuAOy58sh2ImpxW1CgeFjeB42fWXrhyFZ+7H1LzNgC/+myuUy3mbyrTfim9Q+dDFxuOgEvyxmrKS
	 m8Q18g7B194tpoQ7mK4Tw8BNFxSgHSzFtAY0zVa7+Fw7gbUimlh+vrP0ECX2SXyGTrpjWY9P3tHr
	 pVs3Ea5vzfOT9UrNOIfOMgxYD5bqPPR73QFV1eXWsAliVCyOywihhTVWC4vINAAUpPFiNiCsSqMa
	 D5pb8V3r59I2Koqae9RGwRga1qBtBETOsaK34FQfUz96jvzytm+sm2HVGQwCHIyYP4zKX3EQI68D
	 hmPS6Rzi9xNuJu4SIzCQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	eadavis@qq.com,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	martineau@kernel.org,
	matthieu.baerts@tessares.net,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] mptcp: fix uninit-value in mptcp_incoming_options
Date: Fri, 24 Nov 2023 19:05:18 +0800
X-OQ-MSGID: <20231124110517.2777867-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <c1f1f869346f4d6fc90eac6d131454b85fa676be.camel@redhat.com>
References: <c1f1f869346f4d6fc90eac6d131454b85fa676be.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 23 Nov 2023 17:41:31 +0100, Paolo Abeni wrote:
> > Added initialization use_ack to mptcp_parse_option().
> >
> > Reported-by: syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >  net/mptcp/options.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index cd15ec73073e..c53914012d01 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -108,6 +108,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
> >  			mp_opt->suboptions |= OPTION_MPTCP_DSS;
> >  			mp_opt->use_map = 1;
> >  			mp_opt->mpc_map = 1;
> > +			mp_opt->use_ack = 0;
> >  			mp_opt->data_len = get_unaligned_be16(ptr);
> >  			ptr += 2;
> >  		}
> 
> LGTM, and syzbot tested it.
> 
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> 
> @Edward: for future similar patches, please add also the tested tag
> from syzbot, will make tracking easier.
OK, I will.

Edward


