Return-Path: <netdev+bounces-291225-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKxkNHKpE2ptEgcAu9opvQ
	(envelope-from <netdev+bounces-291225-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 03:44:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 060B25C53FA
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 03:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63D483007AEB
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 01:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C51246778;
	Mon, 25 May 2026 01:43:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AF9259C80
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 01:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779673381; cv=none; b=n7qaG6O+xLHxLabyIVZC+vIMOsi0kpjlufJwKJK7r7FnKBpM2k1PrADohppOMutZaCvdFDx1QHYoqid6dCKfJN1+tLwnOYMSm9rQb1zT8lM/sO7oAdPph6xUOB2Jmh46Sfmat7U5rI8126t8looQWlL0Pm8OluIftT8Qikv10MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779673381; c=relaxed/simple;
	bh=aTEL6UDmN/2y+eRgOarmtXE3AJBoftOubaTcLtzNgbw=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ST9QIxUlIRFuX8L4sXcr5lx6lbYapXTS7dKQ7ViaBa8HZOlBhmA2sqFlv1aJ2twtKYWLmudt/9i7/HjnybKQNfm/TI1DJQM4AM5SutZKiNATHBJiKGcnuEl7uMoLKhLm/NtI36VmgTPYMEU+5MycQIGict4BFMUyeuI9VxvYl9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas6t1779673314t961t53775
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [60.186.246.224])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 12658486668262179054
To: "'Chenguang Zhao'" <zhaochenguang@kylinos.cn>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>
Cc: "'Simon Horman'" <horms@kernel.org>,
	<netdev@vger.kernel.org>
References: <20260522070749.1634542-1-zhaochenguang@kylinos.cn>
In-Reply-To: <20260522070749.1634542-1-zhaochenguang@kylinos.cn>
Subject: RE: [net-next] net: txgbe: fix phylink leak on AML init failure
Date: Mon, 25 May 2026 09:41:53 +0800
Message-ID: <03b101dcebe7$aa3205d0$fe961170$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQIwUtBzeX57bJtS28N/SAFwNnEPa7V3KTyg
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OGvgEoGelOUdifqBOiBR/484qYBUuHxZy8BmDhNE1noTub8AUyUMh87O
	MIipDmKqqE5geLft64KU9TNbmD6jhY2KZsMDar8+z/KHC5kqF1v7BywfQ6FUMFLGN/g2Bgz
	OBAE3c7+ZdMgYv+tsrILdNEBTF4sslmBHLfpM6L5CJQqlK+H71/DilCS1EfmgRlv1r8s86Q
	BA/aZhYyhKHTj15zaMUxMBRNZp7GFlx2XW7T+OXFbQy+y+6lukPc+SU8wuv62H82/N1PwJI
	seyf5nRal9A8XNyS/pmB/zdETudbJSFsdNECCS3FNocqNC0mwoGPznqQdc45tfOBglraJBH
	LTaR2WgOYZzS724dbwC+MU/1Ie61IMbC1mdKxkj/bJQaTgNfGV05VUA+5pQDnhZY5w81gQi
	MYOiQihWCdbpAmtSZJAU9qqmBf7pfXRuuixWWsiKFftCdn4nXMJlyejplvW7sAKtN7mgUsZ
	zjfBUTnTFH0UxjfVtE0aiIkNPIahneOmin+B305tsLyLSDk3oFTQp1oUKg6TRh86n9nW94H
	Empy4WZC9sacqgF0OIR5cjvLR81Ld/NmKsxd0pjZVrHvF3+lUqB9yxb38Pih1yWYfRw1kV9
	6rzLX2Nl8ufyb3+usd59n1Rw4vLglJ0OllvVmFKeUGAtFuRpiKZ7DWmf2ULe5Bw9XqmAPHm
	VpR4pnKIIvXEFo3olSSeHVZB6ZK6Nago6XKpr9JjCL9WT+cRA0z4m+VlcdlsBdhTHCgj4Nu
	YNsf0UxjM3rk6UKtiUBBHMAFq6PttyoNGm50xJ1qK1APnG9MOrnauTwL0aVr5r4R/m/oMi9
	kYtggwGr1n915o4UXX2RtmxpPdCpThssml5GPNe+DBx/GferVdjBhOOPCoXJRCDoMxPiWIj
	LNaf32/6TeLtTH/j//cX6DU9ubTR7eZuirgCWNz5MV7tH6852KkMi5YXFbtTyld7G+pp3UF
	iN+PKnqkmuDV4Ypfkji3vkp2l10RTRaScJuIBilh7pWvMLD2Tny+Qyy8/dV33eUFIjw8irB
	3pOu0VNTjeVc72/DIkuzU8nPEchpCXwVRHSyAeS5VOIFzN/mWzSzlBnQHNW5vzC67OZoauw
	pThi2d2ERbXXpEjBv+v/so=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	FROM_EXCESS_BASE64(1.50)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291225-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[trustnetic.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.926];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,trustnetic.com:mid,trustnetic.com:email,kylinos.cn:email]
X-Rspamd-Queue-Id: 060B25C53FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 3:08 PM, Chenguang Zhao wrote:
> Destroy the phylink instance when fixed-link setup fails.
> 
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
>  drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> index f0514251d4f3..8e301e7d1148 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> @@ -521,6 +521,7 @@ int txgbe_phylink_init_aml(struct txgbe *txgbe)
>  	err = phylink_set_fixed_link(phylink, &state);
>  	if (err) {
>  		wx_err(wx, "Failed to set fixed link\n");
> +		phylink_destroy(phylink);
>  		return err;
>  	}
> 

Reviewed-by: Jiawen Wu <jiawenwu@trustnetic.com>

Thanks!
 


