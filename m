Return-Path: <netdev+bounces-237802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EEFC5059D
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 03:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF633B250A
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 02:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C47298991;
	Wed, 12 Nov 2025 02:36:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from r9204.ps.combzmail.jp (r9204.ps.combzmail.jp [160.16.62.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A030035CBDC
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 02:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.16.62.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762914976; cv=none; b=jRqACBngiN5PCHmHiglQG3WCGOfAP1q7uuxeCmWwc4boC1+r4FXAdqOcmI/A4Ig4ElzrIazrZkheI4EtEYhIZPopUD5MAOVpTdq4q1kpRTjxkGXUvc0Y7XMrjsGIqcBrdKS6cnyQcuUatTCpWgk8zM/4S9Ufyp8xzDxOslSGKqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762914976; c=relaxed/simple;
	bh=okEnYFBMjoPo+i4RQRYTcj/jfvTJ/HRJDOaMy79sJMw=;
	h=To:From:Subject:Mime-Version:Content-Type:Message-Id:Date; b=aKfggth8WV2mYPIIfsdkgGGFMVTm+56qHzXx1iRxw4fCpr0kwxTuJYT2pA/9U97zgTD48hQ1PzOCv+J9m4eO1fGneTXgL8CvFamnUV2U4GvLN9MUdGqvJi9B+YS1472ZLINZdhfY541oaIFP/Ie5Lp9jYpZurzGIGdb+/GWltJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fc-session.jp; spf=pass smtp.mailfrom=magerr.combzmail.jp; arc=none smtp.client-ip=160.16.62.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fc-session.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=magerr.combzmail.jp
Received: by r9204.ps.combzmail.jp (Postfix, from userid 99)
	id A50341030C4; Wed, 12 Nov 2025 11:24:28 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 r9204.ps.combzmail.jp A50341030C4
To: netdev@vger.kernel.org
From: =?ISO-2022-JP?B?GyRCNjUwaSVVJWklcyVBJWMlJCU6JTslXyVKITw7dkwzNkkbKEI=?= <info@fc-session.jp>
X-Ip: 267008555586481
X-Ip-source: k85gj7ra48dnsa5pu0p6gd
Precedence: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Subject: =?ISO-2022-JP?B?GyRCPi87UjI9JE9ESSQkSXchIzwhQCRCZSROGyhC?=
 =?ISO-2022-JP?B?GyRCNjUwaSVTJTglTSU5GyhC?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-MagazineId: ra5p
X-uId: 6763325040485967654270211015
X-Sender: CombzMailSender
X-Url: http://www.combzmail.jp/
Message-Id: <20251112022441.A50341030C4@r9204.ps.combzmail.jp>
Date: Wed, 12 Nov 2025 11:24:28 +0900 (JST)

　
　いつもお世話になります。
　
　少子化が進む中で、多くの企業が 「教育市場は縮小する」 と考えています。
　
　しかし実際には、一人あたりの教育支出は年々微増しており、
　教育業界はむしろ堅調に成長を続けています。
　
　今回は、地域貢献と収益性を両立できる
　次世代型の教育事業をテーマに、
　
　新規事業での収益づくりをお考えの法人様向けに
　オンライン説明会を開催いたします。

　11月18日（火）16：00〜17：00　オンライン開催
----------------------------------------------------------

　　　　　◆フランチャイズ事業　WEB説明会◆

　　　　　“プログラミング教育×個別指導”

　　　　　 不況に強く、少子化でも成長する
　　　　　　　 ハイブリッド型の教育事業

　　　　　　　　　▼  視聴予約 ▼
　　　　　　 https://wam-edu-fc.jp/wam2/

　  　　　　　　　◆　ご案内事業　◆
　　　　　　　　　　 個別指導 WAM

　　　　　　　　　◇　　 提供 　　◇
　　　　　　　  エイチ・エム・グループ

----------------------------------------------------------

　『少子化なのに、教育事業？』と思うかもしれませんが、
　実は子ども一人にかける教育費の増加に伴い、市場は成長し続けています。

　また、教育費は不況時でも削減されにくいため
　コロナ下でも大きく落ち込むことなく底堅さを見せました。

　幼児教育無償化などの国策もあり、今後も教育投資の増加が予想されます。

　そこでご紹介するのが、「プログラミング×個別指導」の
　ハイブリッド教育事業です。

　プログラミングは小学校で必修化されたため、保護者の関心も高まっています。

　本事業のスタートは業界未経験・社員１名で可能です。
　新たな事業収益づくりをお考えの方は、是非ご参加ください。


　11月18日（火）16：00〜17：00　オンライン開催
　▼  視聴予約はこちら
　https://wam-edu-fc.jp/wam2/

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
　教育事業FCセミナー事務局
　電話：0120-891-893
　住所：東京都中央区銀座7-13-6
―――――――――――――――――――――――――――――――
　本メールのご不要な方には大変ご迷惑をおかけいたしました。
　今後ご案内が不要な方は下記URLよりお手続きをお願いいたします。
　┗　https://wam-edu-fc.jp/mail/

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

