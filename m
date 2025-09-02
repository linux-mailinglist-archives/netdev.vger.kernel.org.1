Return-Path: <netdev+bounces-219169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3E9B40264
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 15:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 385BD1B222CB
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 13:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E612FF65C;
	Tue,  2 Sep 2025 13:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="QDnB1fl6"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C95303C87;
	Tue,  2 Sep 2025 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756818974; cv=none; b=IPVvWJNA5AOQuQocCj9hkRtEfGQ6tUJx3motS46CDtEI9VezBIOb9fZjGcuypwi6RMzqkLVxRg0pdqIKSZsXskMwxqczmqa6qY+7xprWz7lPlV3w0NVspxYf3uSp1DvmnnmacV7hD/CQevLe54AuZ7vF/zdWA5d4wbM25Ka4szM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756818974; c=relaxed/simple;
	bh=3aVcmt7GxFD55IhIXydC+ZcF773ciy1n9s0YIuvYRZQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=r49Me0+CRLXjXTBEVW/Fvuu+SVqPdQDhRoP+nKY4QUCoG9+o7VKy5dn9NLm4pzzj2Pm3EmDD1RGrbEGmR0ItJvhHw8kZsl2CfEUtflwBlKf5mFLOlFEv87wdFQJoQhkPsl0em264mXCACwBMeQCfn5B3fA1mctFPBPTykn0vhlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=QDnB1fl6; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756818967; x=1757423767; i=markus.elfring@web.de;
	bh=3aVcmt7GxFD55IhIXydC+ZcF773ciy1n9s0YIuvYRZQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QDnB1fl6a0tRhOogKEOjyyvCqMigBdVOXzXn6YjVuZrlpNvpudqDrGh10RF/9nGp
	 E7ijyjZtARYXKst/TDI4Vtn+bnVRJP48I7HW47BI85ISVQpMT2Jybm2N/IReJqKLv
	 QLsENrfbGPVxv7ou1Ciw9qoQcNtgpussFrL+ECc8S63uRH2qQBaYBFQy/YmCmBOrN
	 HfOwsZ/r67/XTUbTL6DywR7X7UZ6SPWBILXsnRK3orJDuEI2kddM8iN6CXGqJBZuq
	 MsNpHKaxQoK1PgoSA3yt2QOyF1rx73UKd7p/n079XRQIDgHM6WYNWAesOs8u/vltU
	 HndvX4Y8qtRGFJBx4w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.184]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MXGOI-1uyHVY3kis-00V8QP; Tue, 02
 Sep 2025 15:16:06 +0200
Message-ID: <91b13729-7b5c-48a2-acb0-9f23822dcf3a@web.de>
Date: Tue, 2 Sep 2025 15:15:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: chuguangqing@inspur.com, netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Antonio Quartulli <antonio@openvpn.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Simon Horman <horms@kernel.org>
References: <20250902090051.1451-2-chuguangqing@inspur.com>
Subject: Re: [PATCH v2 1/1] ovpn: use kmalloc_array() for array space
 allocation
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250902090051.1451-2-chuguangqing@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ZKl/rp3ICt7nvYxkwREESYA2KpK9lRxzHp+sbSqPemGa3WOI6xT
 MYIt6nvA/tnBdopNp9xVVQtDG0bViZ5vCiZx/xL28ttGPB9wZWtGMuLQ/xDawN42+8s+mJ/
 fqFSM+QxFdZgTOxVfNyWoQDhRy/HuikB85Cla3FMY9Uxz/mK7iHBFFrJoQ8LQReuUjanC6Q
 eCw6twXCPC1mSGdsKvrdQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6jNkmipa6v4=;bm2i8/vTQeKi0dqeZDs4mfItTAQ
 c3s2TLkRGHiBBNb2+oYQYIxD+keF1e5L/4Ip21HPa3Uj+2lCDSse1KHqcGfIweumyd+qyl09P
 tCQ6VTaZHI9gjn68XUZrnOwt4YGWd8xrwnTRXN6D5pqmaJkEJ9lXuur6kyW2rBktk01cn/fZ3
 FUAHHv55m2YjBKrxZ5LSQNUJez6EJB75+YkbkukNnySpB6OgEVIsuOWby2bbNIp4AnT5vj6mr
 St5xIkx+vyb0+ke7WG3l8EOaBbG+TBsetRzdjaJehAvZBCxXAs41UICzpqluja5aDY5CxMqBE
 uA1hJSnUwLsSRZ+wCqtYOph3Wq1GLcCoLdhe77H3IWT/vsvgIg2ENItuvpOzOTzE8lQg4MJ6T
 2HnPd3T6swYVO2Nm0mg00wEqXa+bXbXt7FzWucDYHxAVZ3W1jyyGIt/4cJEUtZv1jdtGOjxfu
 tG97HeUbyhYy84PvcVus4DgxJt4hdD1yxuL1iq+scn47VCNhuhfWZf51Pcsrc+WQ/NwnS35Jv
 hJOltUhiFZMrmTzE+sBE0wBxDApkwNeOQYYxFwO+48GMHX+LycAtXv4an76QnajxuNUCJZAXS
 GiJX+xQwHM/QMWfuod/MsrsqqlO3OkyjBRub8suur9gNrUGitmTt5wGXhltviHGmC0xUpO6+h
 l1RdJYmJpLX2gce1FxTHPtSgtntqaQ536hblzlqbYpqbovISGwFtYgaQgNuCxUALFahcblTAc
 8s+QHuI3x9JbM79ZyAxMJplJ/th/YT4iDMMMQSTxZY49RTmBUstUzaArBlMxVgukuqKxzWMyC
 /4cYmhLOnqdpvjGF39MfjwrFZgxay5829ssWlaSWwbks/UbpONW5Q9riM3/78548infs7QTV1
 J8ITEEGjmD5yNDlcaOPDtYdODDhsHROcTn0lA1hr/jwgjQewgVdcMAoPpMcsU+aFzGF1Hremp
 XAUjt2cAWELRqxUJIe/glGD3lNCrbs31hNsHxbWiaZ8vmbWdQu4QNxEQ1l8cf28VAixvqK7rs
 8RSgOVHgZhGixFvmdl4bz/pgT3Cjc1jIituHsqyNq20HRL/mzedAr78sDVDDChMYfpR3bpMtn
 to1/joaYDIywrEjhI9ilYRhaECOGabjDDeBMzwlz6RQn9ygK/FXLa3Z6DMN8xM499GMc2LcQJ
 Mvfcmx7Ok5RXHPQ1cBkGzN1VQYmIARwTkViKTttINHwQ0Woto/OiJTNYINBMikmRDv3ZC4cpk
 OqeR+pVkovVzi3RQmn8tJJYevbULQahKejfolEucmtg9PQLGAKqP5QTdbj4v82GKarUGHRwN2
 MpvfdShN3/MsN7rsEtTGDo4zheyA11yy1NArGvNPPBm7x4cAtF+/ykpn+JrPk917YwjnndZJn
 WnT3/45ThXZNjnJtQUYYai7ogSE5asYM+q+pTgBmUGqDqVudGxGGgFgKnnfm2DaiODpqYNZr/
 z4C7GJeiEYwR+sXjv3hyL8FPVE6Mpi86iBPuA4+cKDo8rAilVxcy8MI+QtCvSuEXYpxjUduuY
 oR7FVoyCIkf63x3mw+Y+v7ArhEQwI4MMpiak6A8fYIWhD+LU98X8gE4i30NcVcVstQzAet8++
 DXFrnC1oAOhcHcioTNaUuZ/Bo1Jhr/VRirZD1UueTgmoMh6tQKOlK5JWahGlkl+QCYr0pn8/y
 7rjMPEPSsUapVrs55ooSIes2/53LZp1w2HeeeIvVX4V0cL5qURzBMfrbRerf3hhtMRFWJh8JC
 qlIbXr0pC5J+lOAkOCfPM30TwDZ/mTzR2FoQDc0u4HSc1Pds8CZjU+HoVvxRm+lfFvqitxFZ8
 0wj8VBlSizFni3sPENCQ+GhOlkwEf3LKp3VUk7x3J+hLuV0cnx/oMIjNmQWT0L6+y9/fKovep
 i83wfWPk109J4Xh+CcFLju675QGzY7DSvYzyThpHixg4Sm9yB01uxmHvOSq3hLM5Ga80QP2Wf
 unoeQOFQ+d5zdb+hsZ2d8r2wf/PvEEivvxxhYCRaE0kwBd+/43TUcRP5f3RWew3XvE3nAsUex
 iZWAkeEjutbbZHDaxvAX7VqwFoH8e5mqL6EFWtbXuxbaP2FfzbrZCphN0AqzH8lPnTWPAbZxf
 qffg81lWcuk1cFoRzT4I+wq8y5jED021TvcgV1SBCMpaWVP5nRkqwIkKH/ZNvBKLPbqivVuHx
 qqp9Lwp1NWTvE8tE75a1oz/XVB27xyz3lbcD+0UU1UPRppN2dzo75ahSOu8ImgC8HNH3hb76W
 fvwYcxv2JsB3ydFwwj2S8XCPU0Dt2wiNAHfRHJ6Qkiha4JrAEkfY+h+DrwJATDCN+rPc7wIcP
 Y8M7ONkGZ/k/Noh8yZDI7CZXDZDiGXGr17XChzUZ8yCKM2ZyEq8FRApz/1ReBKdEEB3AEt1Hq
 KHy1txWlh8oWpcpGMCLqK9QHpxs/IQCiNLMSs3nsKel0i3za+aFamE3Qiv/5f6RDr9TB/MLVa
 sC5eFTfxG1v7DUberF37U4tiYp+53P+jVxEaEtITDD50aOna4+uE3d1PZJSb6GvaWKJA89oRv
 v5jMp1NgxSF7mAia6DomxEuHtxAIq/eaYJ8obnZQ2uF+Fg4braDC7oYS8a3IrC6l25hKtfuDS
 XA+Ko0XtA58uXhbIxvYR/27Pf13Ymc8LbOYRb4MQl4/Ut9S2VQ0VwGuqRIftXDUYdXBKFQC3T
 wnDP50l9pvKGNDFKb2S8zWM0VgQxG3wOoQH4StuvnG/YQkNT8pT2L4Z9VATIt/yMHstqW0ezg
 3h0yAlrqJHVp/QTvQKl7fvLJMoX2csFSnNy11AIzB/muiKozCIiUGGVhLZGpIcrzYsiauVbcB
 bY4KLoYg2rYZacXupi/5YKGvyQS0Xn4/seEBLOlZo1oQEE9cjqddxYe9hg58js0mxca7hNoLM
 bKD6x1Z7BAxb0tbEHMHqYLJRoMFFPVjOlxIwGYiS3Iv0OEbhKjeVLIouW3yf0ZYm8aLWPjPwG
 9+NZ2qFnz312EvJmEF7QOICGFaARd995m2yPx98N0bFQZ1lEP8qy+3H1vkkibZieoVdz1mwtq
 +G0+fsJcDI3PY/d3NwuMw20PxY9SBnsT3Gazi4DIqZca5h2VH2RIOH6TgQkv8rpZ2bisA5Zi3
 F5y/I46A2K4tg934jTzA6779HL2TlBRShPakiNQHOIPDRPPkmkhUrURuvKz1OzXX7YcWx+4XP
 TXlyn6RWYh9dtXrC96kUQcHJY8TXaDdtX95CTz7zWhRSgL9MZQr1P3xcwxg9402WQkz0I0AfX
 NoxHwndL/Oc/01BWxxN6KPHEessQVzp/YERzqYx9LNoKQwRet78kQSK5rwKZ3Clc9ctvjHCN3
 CCEajVCFAG+ATHepfenAE/NBhGKoJHaUKexK2jKWxtYIxZ99LmNeaVgnJP8Z3XlRW+1B8v8jL
 XSGACntmN7I/ifrtSmKzmaTBDnCURSlvQlYZIN2MbVVNo33cyQS4BpapPyFIhtrm+BeD6cJ3A
 d2KQEhD4gRKBw8c6LQfbCpYewLN5f+yuFFlF3n8iUgxpKet02Omak+kDsrVjxfnwoIizAF2hm
 yVJN93GSZp89R841fNd6gqL/jnN/TVSajHn5Z4c7QvRqSEQJ+9c6l0ISSkhgf73M+2VABu/kH
 Zro1vFjraKS3AA4IziImneMJc6iBI/ae7Mynp+KDidG5SD+bN8nnGayPwoEQeDuQXkQy3JbnT
 Ol9qJpA3whyhCyL9kmqIQdAA06ZcrlyVdBwzVf7nnoYN0sK4CK4wbsNtXcRon0zCuNRM3wgLy
 mq6VFrBj15cGy5AD1s0OLbogupy6UePkik9WF2GWbLO+VG179oUP8yQ9i1qLRzMK+qErqswaT
 A4h3ECMy7Y/3nWJELRnPJ5l6JNoLpNgYL8RQ2gZa0IGNuLR+BKPPKA13De67myb7HdJp2yaTX
 W7ZeUBKo55+MUsDkEQ+0LOO6GOl4gNvcQCoLDph053UN6lYVfZEpnl5R2Yf4IdPt8RR6yM8Pa
 D4lKy1AfZtfdtXTBlU8F8Vz07NppLzLdSu7AAERtbST3UUT9BVdyXbJuCvkzu7PgXtKDs0mAV
 NF0iXe5rgOaQ0QLP9pd7yf7y2fxbZdVJpvUgiokO2qgtC79kQ/COwXwrdwbZUUhFAT8SktGoP
 DsKGnli8ZKT/W6C13UNHgwQSON1jv1wZeaDXHkhjxoKZYveYOiW6eyW+KUpbUbsNxFet9vh4Z
 skUoVSYBaMhL5anqYjoMgXaVT6UoC9mS47DZskalkSJCZG1f+wflBNxrXb1IOH7H1M8B4YI+0
 uIJBWBZrwIbwC0B8aVDtHmlA/BtEDI84DwIkEGdbgG8oGjCOc1/BzjAq51DfQMpO4KF3lKxqT
 gCp2QsleZsDM9JtlcOlJxRaYXjQl6eyTsYoQ2oKvuw5v0zHxlsirP6dSvBN7wLTd988CBEmqQ
 RIwvPpfACvrrrWAhlQDyj5jakGpwgg38EOqi4kSMnr7yGdlk3XyonSgzJdrGopKMUWLJadZ8a
 Vmib00M98UNMnnvnzYSND0cQYd1rnmY/o6crXcgCFx07VBX7LWo/H5t6+5un0i109C7MB2wte
 q5ipsSFSSyb0o0SABHynQIsf6u52Ix2CynUXRcpajFq1lLyH+pTZPoSTE1Iby/XIeN6mg3u8z
 5qilJ64lNlJ/CbOgdAgs8Kv/aV3vBy1+luLbeDAuffF+vTrVK9ACOtobEofvryUiOWgjHQbCX
 A6rQh8jkeUP9KdDgpy6mPaMvKC+ddPP7greYNo3shy+BbXmKX/YThsNpE6JeQWKBg8cQNPlAI
 Sknde2WTh13FGhM+HxZiJOPHJIUU2PSc/ZFN8aQaAYWHtLVK22+HjVXpKke8l8=

> Signed-off-by: chuguangqing <chuguangqing@inspur.com>

Would the personal name usually deviate a bit from the email identifier
according to the Developer's Certificate of Origin?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.17-rc4#n436

Regards,
Markus

